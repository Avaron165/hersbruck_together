/// Model for partner action/promotion
class ActionItem {
  final String id;
  final String partnerName;
  final String title;
  final String shortDesc;
  final String longDesc;
  final ActionCategory category;
  final ActionType type;
  final String validityText;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool isNew;
  final String imageUrl;
  final String? redeemCode;
  final String? redeemHint;

  const ActionItem({
    required this.id,
    required this.partnerName,
    required this.title,
    required this.shortDesc,
    required this.longDesc,
    required this.category,
    required this.type,
    required this.validityText,
    this.validFrom,
    this.validTo,
    required this.isNew,
    required this.imageUrl,
    this.redeemCode,
    this.redeemHint,
  });

  /// Check if action is ending soon (within 7 days)
  bool get isEndingSoon {
    if (validTo == null) return false;
    final daysLeft = validTo!.difference(DateTime.now()).inDays;
    return daysLeft >= 0 && daysLeft <= 7;
  }

  /// Get badge text based on type and status
  String get badgeText {
    if (isNew) return 'Neu';
    switch (type) {
      case ActionType.rabatt:
        return 'Rabatt';
      case ActionType.aktion:
        return 'Aktion';
      case ActionType.special:
        return 'Special';
    }
  }
}

/// Categories for filtering actions
enum ActionCategory {
  food,
  sport,
  kultur,
  shopping,
  wellness,
  freizeit,
}

extension ActionCategoryExtension on ActionCategory {
  String get displayName {
    switch (this) {
      case ActionCategory.food:
        return 'Food';
      case ActionCategory.sport:
        return 'Sport';
      case ActionCategory.kultur:
        return 'Kultur';
      case ActionCategory.shopping:
        return 'Shopping';
      case ActionCategory.wellness:
        return 'Wellness';
      case ActionCategory.freizeit:
        return 'Freizeit';
    }
  }
}

/// Types of actions
enum ActionType {
  rabatt,
  aktion,
  special,
}

/// Sorting options for actions list
enum ActionSortOption {
  newest,
  endingSoon,
  alphabetical,
}
