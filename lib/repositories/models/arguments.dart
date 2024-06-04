class ArgumentsMitra {
  dynamic venueId;
  dynamic venue;
  dynamic lapangan;
  dynamic selectedDateIndex;

  ArgumentsMitra(
      {required this.venueId,
      required this.venue,
      required this.lapangan,
      required this.selectedDateIndex});

  Map<String, dynamic> toJson() {
    return {
      'venueId': venueId,
      'venue': venue,
      'lapangan': lapangan,
      'selectedDateIndex': selectedDateIndex,
    };
  }
}
