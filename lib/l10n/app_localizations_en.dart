// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'My Buku';

  @override
  String get digitalLibrary => 'Digital Library';

  @override
  String get onboardingTitle1 => 'Welcome to\nMy Buku';

  @override
  String get onboardingDesc1 =>
      'Discover interesting books in your digital library.';

  @override
  String get onboardingTitle2 => 'Read Anytime,\nAnywhere';

  @override
  String get onboardingDesc2 =>
      'Access the entire book collection anytime and anywhere.';

  @override
  String get onboardingTitle3 => 'Manage Your Collection\nand Loans';

  @override
  String get onboardingDesc3 =>
      'Borrow, read, and return books easily anytime.';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get start => 'Get Started';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginSubtitle => 'Welcome back!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get login => 'Sign In';

  @override
  String get or => 'or';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Register';

  @override
  String get emailPasswordEmpty => 'Email and password cannot be empty.';

  @override
  String get registerTitle => 'Create New Account';

  @override
  String get registerSubtitle => 'Register to start reading';

  @override
  String get fullName => 'Full Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get allFieldsRequired => 'All fields are required.';

  @override
  String get passwordMismatch => 'Passwords do not match.';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters.';

  @override
  String get haveAccount => 'Already have an account? ';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordDesc =>
      'Enter your email and we will send you instructions to reset your password.';

  @override
  String get enterEmail => 'Please enter your email address.';

  @override
  String get emailSent => 'Email Sent!';

  @override
  String get checkInbox =>
      'Check your email inbox for password reset instructions.';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get sendInstructions => 'Send Instructions';

  @override
  String get userNotFound => 'Email is not registered.';

  @override
  String get invalidEmail => 'Invalid email format.';

  @override
  String get genericError => 'An error occurred. Please try again.';

  @override
  String get welcome => 'Welcome! 👋';

  @override
  String get searchHint => 'Search books, authors, or genres...';

  @override
  String get totalBooks => 'Total Books';

  @override
  String get borrowed => 'Borrowed';

  @override
  String get available => 'Available';

  @override
  String get transactions => 'Transactions';

  @override
  String get mainMenu => 'Main Menu';

  @override
  String get searchBooks => 'Search';

  @override
  String get location => 'Location';

  @override
  String get favorites => 'Favorites';

  @override
  String get popularGenres => 'Popular Genres';

  @override
  String get genreHistory => 'History';

  @override
  String get genreCulture => 'Culture';

  @override
  String get genreLiterature => 'Literature';

  @override
  String get genreCulinary => 'Culinary';

  @override
  String get genreNature => 'Nature';

  @override
  String get genreTechnology => 'Technology';

  @override
  String get latestBooks => 'Latest Books';

  @override
  String get viewAll => 'View All';

  @override
  String get failedLoadBooks => 'Failed to load books';

  @override
  String get noBooksYet => 'No books yet';

  @override
  String removedFromFavorites(String title) {
    return '$title removed from favorites';
  }

  @override
  String addedToFavorites(String title) {
    return '$title added to favorites ❤️';
  }

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get profile => 'Profile';

  @override
  String get bookDetail => 'Book Detail';

  @override
  String get publisher => 'Publisher';

  @override
  String get year => 'Year';

  @override
  String get pages => 'Pages';

  @override
  String get stock => 'Stock';

  @override
  String get description => 'Description';

  @override
  String get bookInfo => 'Book Information';

  @override
  String get author => 'Author';

  @override
  String get publishYear => 'Published Year';

  @override
  String get pageCount => 'Page Count';

  @override
  String pagesUnit(int count) {
    return '$count pages';
  }

  @override
  String get genre => 'Genre';

  @override
  String get shelfLocation => 'Shelf Location';

  @override
  String get borrowBook => 'Borrow Book';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get confirmBorrow => 'Are you sure you want\nto borrow this book?';

  @override
  String get borrowDueInfo => 'Return deadline is 7 days from now';

  @override
  String get cancel => 'Cancel';

  @override
  String get yesBorrow => 'Yes, Borrow';

  @override
  String get borrowSuccess => '✅ Book borrowed successfully!';

  @override
  String borrowFailed(String error) {
    return 'Failed to borrow: $error';
  }

  @override
  String get favoriteBooks => 'Favorite Books';

  @override
  String get noFavorites => 'No favorite books yet';

  @override
  String get addFavoritesHint => 'Tap the ❤️ icon on the search page to add';

  @override
  String get bookSearch => 'Book Search';

  @override
  String get searchTitleAuthor => 'Search title or author...';

  @override
  String get all => 'All';

  @override
  String get genreLanguage => 'Language';

  @override
  String get genreEconomy => 'Economy';

  @override
  String get failedLoadData => 'Failed to load data';

  @override
  String get bookNotFound => 'Book not found';

  @override
  String get tryOtherKeyword => 'Try another genre or keyword';

  @override
  String booksFound(int count) {
    return '$count books found';
  }

  @override
  String get yourName => 'Your Name';

  @override
  String get myAccount => 'My Account';

  @override
  String get borrowHistory => 'Borrow History';

  @override
  String get myFavorites => 'My Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get help => 'Help';

  @override
  String get logout => 'Logout';

  @override
  String get confirmation => 'Confirmation';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationSubtitle => 'Book due date reminders';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'Change app theme';

  @override
  String get others => 'Others';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get needMoreHelp => 'Need More Help?';

  @override
  String get contactLibrarian =>
      'Contact our librarian or admin for borrowing issues.';

  @override
  String get contactAdmin => 'Contact Admin';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get faq1Question => 'How long is the borrowing period?';

  @override
  String get faq1Answer =>
      'The standard borrowing period is 7 days. You can extend it once through the app.';

  @override
  String get faq2Question => 'What if I return late?';

  @override
  String get faq2Answer =>
      'Late returns will be charged a daily fine according to library regulations.';

  @override
  String get faq3Question => 'Can I borrow more than 3 books?';

  @override
  String get faq3Answer =>
      'Currently, the maximum borrowing limit is 3 books at a time for regular members.';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePhotoHint => 'Tap the camera icon to change photo';

  @override
  String get photoSource => 'Choose Photo Source';

  @override
  String get camera => 'Camera';

  @override
  String get takeNewPhoto => 'Take a new photo';

  @override
  String get gallery => 'Gallery';

  @override
  String get pickFromGallery => 'Pick from gallery';

  @override
  String get nameRequired => 'Name cannot be empty';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get emailCannotChange => 'Email cannot be changed';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneHint => 'Example: 08123456789';

  @override
  String get address => 'Address';

  @override
  String get enterAddress => 'Enter your address';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get profileUpdated => 'Profile updated successfully! 🎉';

  @override
  String profileUpdateFailed(String error) {
    return 'Failed to update profile: $error';
  }

  @override
  String imagePickFailed(String error) {
    return 'Failed to pick image: $error';
  }

  @override
  String get transactionTitle => 'Transactions';

  @override
  String get filterAll => 'All';

  @override
  String get filterBorrow => 'Borrow';

  @override
  String get filterBuy => 'Buy';

  @override
  String get failedLoadTransactions => 'Failed to load transactions';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get borrowLabel => 'BORROW';

  @override
  String get buyLabel => 'BUY';

  @override
  String get dueDate => 'Due Date:';

  @override
  String get returnBook => 'Return';

  @override
  String get returnSuccess => 'Book returned successfully';

  @override
  String failedAction(String error) {
    return 'Failed: $error';
  }

  @override
  String get libraryLocation => 'Library Location';

  @override
  String get noLibraryData => 'No library data available.';

  @override
  String get viewOnMap => 'View on Map';

  @override
  String get getDirections => 'Get Directions';

  @override
  String get privacyPolicyContent =>
      'Your privacy is important to us. This application collects minimal user profile data such as your name, email, and loan history strictly to manage library borrowings and personalized app preferences. Your data is stored securely and will never be shared with third parties without your explicit permission.';

  @override
  String get termsConditionsContent =>
      'By using My Buku, you agree to comply with library regulations. The standard book borrowing duration is 7 days. Late returns are subject to penalties and fines calculated daily. Users are expected to maintain the condition of borrowed materials. The account limit is capped at 3 simultaneous book loans.';
}
