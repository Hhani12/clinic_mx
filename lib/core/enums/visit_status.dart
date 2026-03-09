enum VisitStatus {
  scheduled,
  checkedIn,
  inTreatment,
  completed,
  noShow,
  cancelled,
}

extension VisitStatusX on VisitStatus {
  String get value {
    switch (this) {
      case VisitStatus.scheduled:
        return 'scheduled';
      case VisitStatus.checkedIn:
        return 'checked_in';
      case VisitStatus.inTreatment:
        return 'in_treatment';
      case VisitStatus.completed:
        return 'completed';
      case VisitStatus.noShow:
        return 'no_show';
      case VisitStatus.cancelled:
        return 'cancelled';
    }
  }

  String get labelAr {
    switch (this) {
      case VisitStatus.scheduled:
        return 'مجدول';
      case VisitStatus.checkedIn:
        return 'تم الوصول';
      case VisitStatus.inTreatment:
        return 'قيد العلاج';
      case VisitStatus.completed:
        return 'مكتمل';
      case VisitStatus.noShow:
        return 'لم يحضر';
      case VisitStatus.cancelled:
        return 'ملغي';
    }
  }

  static VisitStatus fromString(String? value) {
    switch (value) {
      case 'scheduled':
        return VisitStatus.scheduled;
      case 'checked_in':
        return VisitStatus.checkedIn;
      case 'in_treatment':
        return VisitStatus.inTreatment;
      case 'completed':
        return VisitStatus.completed;
      case 'no_show':
        return VisitStatus.noShow;
      case 'cancelled':
      default:
        return VisitStatus.cancelled;
    }
  }
}
