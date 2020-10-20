class TimeAgo {
  static String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if ((difference.inDays / 365).floor() >= 1)
      return '${(difference.inDays / 365).floor()} tahun yang lalu';

    if ((difference.inDays / 30).floor() >= 1)
      return '${(difference.inDays / 30).floor()} bulan yang lalu';

    if ((difference.inDays / 7).floor() >= 1)
      return '${(difference.inDays / 7).floor()} minggu yang lalu';

    if (difference.inDays >= 1) return '${difference.inDays} hari yang lalu';

    if (difference.inHours >= 1) return '${difference.inHours} jam yang lalu';

    if (difference.inMinutes >= 1)
      return '${difference.inMinutes} menit yang lalu';

    return 'Sekarang';
  }
}
