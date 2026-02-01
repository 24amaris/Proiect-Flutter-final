/// Toate constantele de text folosite în aplicație
/// Acest fișier centralizează toate string-urile pentru a evita hardcoding-ul
class AppStrings {
  // Constructor privat pentru a preveni instanțierea
  AppStrings._();

  // App Name
  static const String appName = 'WishList';

  // Home Screen
  static const String homeEmptyTitle = 'Nicio destinație încă';
  static const String homeEmptyMessage =
      'Adaugă-ți primele destinații de vis și începe să-ți planifici aventurile!';
  static const String homeEmptyButton = 'Adaugă prima destinație';
  static const String homeAddButton = 'Adaugă';
  static const String homeFilterAll = 'Toate';
  static const String homeFilterVisited = 'Vizitate';
  static const String homeFilterNotVisited = 'De vizitat';
  static const String homeSortName = 'Nume';
  static const String homeSortCountry = 'Țară';
  static const String homeSortBudget = 'Preț';
  static const String homeStatisticsTitle = 'Statistici';
  static const String homeStatisticsTotal = 'Total destinații';
  static const String homeStatisticsVisited = 'Vizitate';
  static const String homeStatisticsRemaining = 'De vizitat';
  static const String homeStatisticsAvgBudget = 'Buget mediu';

  // Destination Card
  static const String cardVisited = 'Vizitat';
  static const String cardVisitedBadge = 'Vizitat';
  static const String cardMarkButton = 'Marchează';
  static const String cardDeleteButton = 'Șterge';

  // Add Destination Screen
  static const String addTitle = 'Adaugă Destinație';
  static const String addNameLabel = 'Nume destinație';
  static const String addNameHint = 'Ex: Paris';
  static const String addCountryLabel = 'Țară';
  static const String addCountryHint = 'Ex: Franța';
  static const String addDescriptionLabel = 'Descriere';
  static const String addDescriptionHint = 'Descrie destinația...';
  static const String addImageLabel = 'URL Imagine';
  static const String addImageHint = 'https://example.com/image.jpg';
  static const String addSeasonsLabel = 'Sezoane recomandate';
  static const String addBudgetLabel = 'Buget estimat (EUR)';
  static const String addBudgetHint = 'Ex: 1500';
  static const String addAttractionsLabel = 'Atracții turistice';
  static const String addAttractionsHint = 'Separate prin virgulă';
  static const String addVisitedCheckbox = 'Am vizitat deja această destinație';
  static const String addSaveButton = 'Salvează Destinația';

  // Seasons
  static const String seasonSpring = 'Primăvară';
  static const String seasonSummer = 'Vară';
  static const String seasonAutumn = 'Toamnă';
  static const String seasonWinter = 'Iarnă';

  // Validation Messages
  static const String validationNameRequired = 'Te rog introdu numele destinației';
  static const String validationCountryRequired = 'Te rog introdu țara';
  static const String validationDescriptionRequired = 'Te rog adaugă o descriere';
  static const String validationImageRequired = 'Te rog adaugă un URL pentru imagine';
  static const String validationSeasonsRequired = 'Te rog selectează cel puțin un sezon';
  static const String validationBudgetRequired = 'Te rog introdu bugetul estimat';
  static const String validationAttractionsRequired = 'Te rog adaugă cel puțin o atracție';

  // Detail Screen
  static const String detailAboutTitle = 'Despre';
  static const String detailPeriodTitle = 'Perioada recomandată';
  static const String detailAttractionsTitle = 'Atracții Turistice';

  // Delete Dialog
  static const String deleteDialogTitle = 'Șterge destinație';
  static const String deleteDialogMessage =
      'Ești sigur că vrei să ștergi această destinație?';
  static const String deleteDialogCancel = 'Anulează';
  static const String deleteDialogConfirm = 'Șterge';

  // Welcome Screen
  static const String welcomeTitle = 'Bun venit la WishList';
  static const String welcomeSubtitle = 'Planifică-ți călătoriile de vis';
  static const String welcomeDescription =
      'Creează-ți lista personală de destinații, organizează-ți călătoriile după sezoane și buget, și transformă visurile în amintiri.';
  static const String welcomeFeature1 = 'Organizează destinațiile tale preferate';
  static const String welcomeFeature2 = 'Filtrează după sezoane și buget';
  static const String welcomeFeature3 = 'Marchează locurile vizitate';
  static const String welcomeStartButton = 'Începe să planifici';
}
