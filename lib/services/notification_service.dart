import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Service untuk mengelola notifikasi lokal pengingat tenggat peminjaman buku.
///
/// Setiap transaksi pinjam mendapat 2 notifikasi:
///   - H-1 sebelum jatuh tempo (jam 08:00 pagi)
///   - Tepat di hari jatuh tempo (jam 08:00 pagi)
class NotificationService {
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  // Channel Android
  static const _channelId = 'perpustakaan_deadline';
  static const _channelName = 'Tenggat Peminjaman';
  static const _channelDesc = 'Pengingat batas waktu pengembalian buku';

  /// Inisialisasi plugin. Panggil sekali di main() setelah Firebase.initializeApp().
  Future<void> init() async {
    if (_initialized) return;

    // Inisialisasi data timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Bisa tambahkan navigasi ke halaman transaksi jika diperlukan
      },
    );

    // Minta izin notifikasi untuk Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _initialized = true;
  }

  /// Jadwalkan 2 notifikasi untuk satu transaksi pinjam.
  ///
  /// [transactionId] digunakan sebagai base ID notifikasi (harus unik).
  /// [bookTitle] judul buku untuk ditampilkan di notifikasi.
  /// [dueDate] tanggal jatuh tempo pengembalian.
  Future<void> scheduleDeadlineNotifications({
    required String transactionId,
    required String bookTitle,
    required DateTime dueDate,
  }) async {
    if (!_initialized) await init();

    // Gunakan hash dari transactionId sebagai int ID notifikasi
    final baseId = transactionId.hashCode.abs();

    final notifDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    // ── Notifikasi H-1 ────────────────────────────────────────────────────
    final oneDayBefore = dueDate.subtract(const Duration(days: 1));
    final oneDayBeforeAt8 = DateTime(
      oneDayBefore.year,
      oneDayBefore.month,
      oneDayBefore.day,
      8, 0, 0,
    );

    if (oneDayBeforeAt8.isAfter(DateTime.now())) {
      await _plugin.zonedSchedule(
        baseId, // ID unik H-1
        '⚠️ Pengingat Pengembalian Buku',
        '"$bookTitle" harus dikembalikan besok! Jangan sampai terlambat.',
        tz.TZDateTime.from(oneDayBeforeAt8, tz.local),
        notifDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }

    // ── Notifikasi hari H ──────────────────────────────────────────────────
    final onDueDateAt8 = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day,
      8, 0, 0,
    );

    if (onDueDateAt8.isAfter(DateTime.now())) {
      await _plugin.zonedSchedule(
        baseId + 1, // ID unik hari H (baseId+1)
        '🚨 Tenggat Pengembalian Hari Ini!',
        '"$bookTitle" harus dikembalikan hari ini sebelum perpustakaan tutup.',
        tz.TZDateTime.from(onDueDateAt8, tz.local),
        notifDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }
  }

  /// Batalkan semua notifikasi untuk transaksi tertentu (saat buku dikembalikan).
  Future<void> cancelDeadlineNotifications(String transactionId) async {
    final baseId = transactionId.hashCode.abs();
    await _plugin.cancel(baseId);
    await _plugin.cancel(baseId + 1);
  }

  /// Batalkan semua notifikasi (untuk keperluan testing / logout).
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
