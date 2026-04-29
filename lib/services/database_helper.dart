import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/extended_models.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  
  factory DatabaseHelper() {
    return _instance;
  }
  
  DatabaseHelper._internal();
  
  static Database? _database;
  
  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }
  
  /// Initialize database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);
    
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }
  
  /// Create all tables
  Future<void> _createDB(Database db, int version) async {
    print('${LogTags.database} Creating database v$version');
    
    // Media Items Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS media_items (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        url TEXT NOT NULL,
        thumbnailUrl TEXT,
        description TEXT,
        duration INTEGER,
        uploadDate TEXT,
        viewCount INTEGER,
        channel TEXT,
        type TEXT,
        addedDate TEXT
      )
    ''');
    
    // Downloads Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS downloads (
        id TEXT PRIMARY KEY,
        mediaId TEXT NOT NULL,
        title TEXT NOT NULL,
        filePath TEXT NOT NULL,
        totalSize INTEGER,
        downloadedSize INTEGER,
        status TEXT,
        startTime TEXT,
        endTime TEXT,
        type TEXT,
        thumbnailPath TEXT,
        retryCount INTEGER,
        errorMessage TEXT,
        FOREIGN KEY (mediaId) REFERENCES media_items(id)
      )
    ''');
    
    // Playlists Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS playlists (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        mediaIds TEXT,
        createdDate TEXT,
        lastModified TEXT,
        coverImagePath TEXT
      )
    ''');
    
    // Playlist Items Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS playlist_items (
        id TEXT PRIMARY KEY,
        playlistId TEXT NOT NULL,
        mediaId TEXT NOT NULL,
        position INTEGER,
        FOREIGN KEY (playlistId) REFERENCES playlists(id),
        FOREIGN KEY (mediaId) REFERENCES media_items(id)
      )
    ''');
    
    // Audio Metadata Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS audio_metadata (
        mediaId TEXT PRIMARY KEY,
        customImagePath TEXT,
        originalThumbnail TEXT,
        lastPlayed TEXT,
        playCount INTEGER,
        likeCount INTEGER,
        isFavorite INTEGER,
        FOREIGN KEY (mediaId) REFERENCES media_items(id)
      )
    ''');
    
    // Recently Played Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS recently_played (
        id TEXT PRIMARY KEY,
        mediaId TEXT NOT NULL,
        lastPlayedDate TEXT,
        playDuration INTEGER,
        FOREIGN KEY (mediaId) REFERENCES media_items(id)
      )
    ''');
    
    // Settings Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS app_settings (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
    
    // Bookmarks/Watch History Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS watch_history (
        id TEXT PRIMARY KEY,
        mediaId TEXT NOT NULL,
        watchedAt TEXT,
        watchedDuration INTEGER,
        totalDuration INTEGER,
        FOREIGN KEY (mediaId) REFERENCES media_items(id)
      )
    ''');
  }
  
  /// Upgrade database schema
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    print('${LogTags.database} Upgrading database from v$oldVersion to v$newVersion');
    
    if (oldVersion < 2) {
      // Add new tables for v2
      await db.execute('''
        CREATE TABLE IF NOT EXISTS audio_metadata (
          mediaId TEXT PRIMARY KEY,
          customImagePath TEXT,
          originalThumbnail TEXT,
          lastPlayed TEXT,
          playCount INTEGER,
          likeCount INTEGER,
          isFavorite INTEGER
        )
      ''');
    }
  }
  
  // ==================== Media Items Operations ====================
  
  Future<void> addMediaItem(MediaItem item) async {
    final db = await database;
    await db.insert(
      'media_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('${LogTags.database} Added media item: ${item.title}');
  }
  
  Future<void> addMediaItems(List<MediaItem> items) async {
    final db = await database;
    final batch = db.batch();
    
    for (final item in items) {
      batch.insert(
        'media_items',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit(noResult: true);
    print('${LogTags.database} Added ${items.length} media items');
  }
  
  Future<List<MediaItem>> getAllMediaItems() async {
    final db = await database;
    final maps = await db.query('media_items');
    return List.generate(maps.length, (i) => MediaItem.fromMap(maps[i]));
  }
  
  Future<MediaItem?> getMediaItem(String id) async {
    final db = await database;
    final maps = await db.query(
      'media_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isEmpty) return null;
    return MediaItem.fromMap(maps.first);
  }
  
  Future<void> updateMediaItem(MediaItem item) async {
    final db = await database;
    await db.update(
      'media_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
  
  Future<void> deleteMediaItem(String id) async {
    final db = await database;
    await db.delete(
      'media_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // ==================== Downloads Operations ====================
  
  Future<void> addDownload(DownloadItem item) async {
    final db = await database;
    await db.insert(
      'downloads',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('${LogTags.database} Added download: ${item.title}');
  }
  
  Future<List<DownloadItem>> getAllDownloads() async {
    final db = await database;
    final maps = await db.query('downloads');
    return List.generate(maps.length, (i) => DownloadItem.fromMap(maps[i]));
  }
  
  Future<List<DownloadItem>> getDownloadsByStatus(DownloadStatus status) async {
    final db = await database;
    final maps = await db.query(
      'downloads',
      where: 'status = ?',
      whereArgs: [status.toString()],
    );
    return List.generate(maps.length, (i) => DownloadItem.fromMap(maps[i]));
  }
  
  Future<void> updateDownload(DownloadItem item) async {
    final db = await database;
    await db.update(
      'downloads',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
  
  Future<void> deleteDownload(String id) async {
    final db = await database;
    await db.delete(
      'downloads',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // ==================== Playlists Operations ====================
  
  Future<void> addPlaylist(Playlist playlist) async {
    final db = await database;
    await db.insert(
      'playlists',
      playlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('${LogTags.database} Added playlist: ${playlist.name}');
  }
  
  Future<List<Playlist>> getAllPlaylists() async {
    final db = await database;
    final maps = await db.query('playlists');
    return List.generate(maps.length, (i) => Playlist.fromMap(maps[i]));
  }
  
  Future<Playlist?> getPlaylist(String id) async {
    final db = await database;
    final maps = await db.query(
      'playlists',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isEmpty) return null;
    return Playlist.fromMap(maps.first);
  }
  
  Future<void> updatePlaylist(Playlist playlist) async {
    final db = await database;
    await db.update(
      'playlists',
      playlist.toMap(),
      where: 'id = ?',
      whereArgs: [playlist.id],
    );
  }
  
  Future<void> deletePlaylist(String id) async {
    final db = await database;
    await db.delete('playlists', where: 'id = ?', whereArgs: [id]);
  }
  
  // ==================== Audio Metadata Operations ====================
  
  Future<void> updateAudioMetadata(AudioMetadata metadata) async {
    final db = await database;
    await db.insert(
      'audio_metadata',
      metadata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<AudioMetadata?> getAudioMetadata(String mediaId) async {
    final db = await database;
    final maps = await db.query(
      'audio_metadata',
      where: 'mediaId = ?',
      whereArgs: [mediaId],
    );
    
    if (maps.isEmpty) return null;
    return AudioMetadata.fromMap(maps.first);
  }
  
  // ==================== Settings Operations ====================
  
  Future<void> saveSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'app_settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<String?> getSetting(String key) async {
    final db = await database;
    final maps = await db.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    
    if (maps.isEmpty) return null;
    return maps.first['value'] as String?;
  }
  
  Future<void> saveAppSettings(AppSettings settings) async {
    final db = await database;
    final data = settings.toMap();
    
    for (final entry in data.entries) {
      await db.insert(
        'app_settings',
        {'key': entry.key, 'value': entry.value.toString()},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  
  // ==================== Utility Operations ====================
  
  Future<void> clearAllData() async {
    final db = await database;
    await db.execute('DELETE FROM media_items');
    await db.execute('DELETE FROM downloads');
    await db.execute('DELETE FROM playlists');
    await db.execute('DELETE FROM playlist_items');
    await db.execute('DELETE FROM audio_metadata');
    await db.execute('DELETE FROM watch_history');
    print('${LogTags.database} All data cleared');
  }
  
  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
    print('${LogTags.database} Database closed');
  }
}
