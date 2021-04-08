String getUniversalDateTimeIso8601ZString(DateTime datetime) {
  return datetime.toUtc().toIso8601String();
}
