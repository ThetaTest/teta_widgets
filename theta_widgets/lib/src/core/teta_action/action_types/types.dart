enum TetaActionType {
  // Alert
  alertShowSnackbar('Show Snack Bar'),

  // Airtable
  airtableDelete('Delete'),
  airtableInsert('Insert'),
  airtableUpdate('Update'),

  // AudioPlayer
  audioPlayerLoopOne('Loop One'),
  audioPlayerLoopAll('Loop All'),
  audioPlayerLoopOff('Loop Off'),
  audioPlayerPause('Pause'),
  audioPlayerPlay('Play'),
  audioPlayerNextTrack('Next Track'),
  audioPlayerPreviousTrack('Previous Track'),
  audioPlayerReload('Reload'),

  // Braintree
  braintreeBuy('Buy'),

  // Camera
  cameraAlwaysFlash('Always Flash'),
  cameraAutoFlash('Auto Flash'),
  cameraOffFlash('Off Flash'),
  cameraStartRecoring('Start Recording'),
  cameraStopRecording('Stop Recording'),
  cameraSwitchCamera('Switch Camera'),
  cameraTakePhoto('Take Photo'),
  cameraTorchFlash('Torch Flash'),

  // Custom Functions
  customFunction('Custom Function'),

  // Google Maps
  googleMapsReloadData('Reload Data'),
  googleMapsSetCameraPosition('Set Camera Position'),
  googleMapsUpdateDeviceLiveLocation('Update Device Live Location'),

  // Custom HTTP Requests
  customHttpDelete('Delete'),
  customHttpPost('Post'),
  customHttpUpdate('Update'),

  // Mixpanel
  mixpanelTrack('Track'),
  mixpanelSetUserId('Set User ID'),

  // Api Calls
  apiCallsExecute('Execute Api Call'),

  // Navigation
  navigationGoBack('Go Back'),
  navigationInAppReview('In-App Review'),
  navigationLaunchUrl('Launch URL'),
  navigationOpenBottomSheet('Open Bottom Sheet'),
  navigationOpenDatePicker('Open Date Picker'),
  navigationOpenDrawer('Open Drawer'),
  navigationOpenPage('Open Page'),
  navigationOpenSnackBar('Open Snack Bar'),
  navigationShare('Share'),

  // Qonversion
  qonversionBuy('Buy'),
  qonversionRestore('Restore'),

  // RevenueCat
  revenueCatBuy('Buy'),
  revenueCatRestore('Restore'),

  // State
  stateChangeWithParam('Change With Param'),
  stateChangeWith('Change With'),
  stateDecrement('Decrement'),
  stateEmailValidator('Email Validator'),
  stateGetTimeNow('Get Time Now'),
  stateIncrement('Increment'),
  statePasswordValidator('Password Validator'),
  statePhoneValidator('Phone Validator'),
  statePickFile('Pick File'),
  stateWebsiteValidator('Website Validator'),
  stateUnfocus('Unfocus'),

  // Stripe
  stripeCheckout('Checkout'),
  stripeAddListItemToCart('Add List Item To Cart'),
  stripeCartBuyAll('Buy All'),
  stripeCartRemoveListItem('Remove List Item'),
  stripeShowReceipt('Show Receipt'),

  // Firebase Analytics
  firebaseAnalyticsSetUserId('Set User ID'),
  firebaseAnalyticsSetUserProperty('Set User Property'),
  firebaseAnalyticsLogEvent('Log Event'),
  firebaseAnalyticsLogAppOpen('Log App Open'),
  firebaseAnalyticsLogJoinGroup('Log Join Group'),
  firebaseAnalyticsLogLogin('Log Login'),
  firebaseAnalyticsLogShare('Log Share'),
  firebaseAnalyticsLogScreenView('Log Screen View'),
  firebaseAnalyticsResetAnalyticsData('Reset Analytics Data'),
  firebaseAnalyticsSetCurrentScreen('Set Current Screen'),

  // Firebase Messaging
  firebaseMessagingSubscribeToTopic('Subscribe To Topic'),
  firebaseMessagingUnsubscribeFromTopic('Unsubscribe From Topic'),

  // Supabase
  supabaseDelete('Delete'),
  supabaseInsert('Insert'),
  supabaseFunctionInvoke('Function Invoke'),
  supabaseOnAll('On All'),
  supabaseOnDelete('On Delete'),
  supabaseOnInsert('On Insert'),
  supabaseOnUpdate('On Update'),
  supabaseSignInWithCredentials('Sign In With Credentials'),
  supabaseSignInWithProvider('Sign In With Provider'),
  supabaseSignUpWithCredentials('Sign Up'),
  supabaseStorageDelete('Storage Delete'),
  supabaseStorageUpload('Storage Upload'),
  supabaseUpdate('Update'),

  // Teta CMS
  tetaCmsAuthLogin('Social Login'),
  tetaCmsAuthLogout('Logout'),
  tetaCmsDbDelete('Delete'),
  tetaCmsDbInsert('Insert'),
  tetaCmsDbUpdate('Update'),
  tetaCmsDbOnAll('On All'),

  // Teta Store
  tetaStoreCheckout('Checkout'),

  // Theme
  themeChangeTheme('Change Theme'),

  // Translator
  translatorTranslate('Translate'),

  // WebView
  webViewGoBack('Go Back'),
  webViewGoForward('Go Forward'),
  webViewReload('Reload'),
  webViewNavigateTo('Navigate To');

  const TetaActionType(this.actionName);
  final String actionName;

  // ACTION GROUPS

  static List<TetaActionType> get alertActions => [
        alertShowSnackbar,
      ];

  static List<TetaActionType> get stateActions => [
        stateIncrement,
        stateDecrement,
        stateChangeWith,
        stateChangeWithParam,
        stateEmailValidator,
        statePhoneValidator,
        stateWebsiteValidator,
        statePasswordValidator,
        statePickFile,
        stateUnfocus,
        // stateGetTimeNow,
      ];

  static List<TetaActionType> get navigationActions => [
        navigationGoBack,
        navigationOpenDrawer,
        navigationLaunchUrl,
        navigationOpenPage,
        navigationOpenBottomSheet,
        navigationOpenSnackBar,
        navigationOpenDatePicker,
        navigationInAppReview,
        navigationShare,
      ];

  static List<TetaActionType> get tetaAuthActions => [
        tetaCmsAuthLogin,
        tetaCmsAuthLogout,
      ];

  static List<TetaActionType> get tetaDbActions => [
        tetaCmsDbDelete,
        tetaCmsDbInsert,
        tetaCmsDbUpdate,
        // tetaCmsDbOnAll,
      ];

  static List<TetaActionType> get tetaStoreActions => [
        tetaStoreCheckout,
      ];

  static List<TetaActionType> get customHttpActions => [
        customHttpDelete,
        customHttpPost,
        customHttpUpdate,
      ];

  static List<TetaActionType> get apiCallsActions => [
        TetaActionType.apiCallsExecute,
      ];

  static List<TetaActionType> get translatorActions => [
        translatorTranslate,
      ];

  static List<TetaActionType> get themeActions => [
        themeChangeTheme,
      ];

  static List<TetaActionType> get mixpanelActions => [
        mixpanelTrack,
        mixpanelSetUserId,
      ];

  static List<TetaActionType> get firebaseAnalyticsActions => [
        firebaseAnalyticsSetUserId,
        firebaseAnalyticsSetUserProperty,
        firebaseAnalyticsLogEvent,
        firebaseAnalyticsLogAppOpen,
        firebaseAnalyticsLogJoinGroup,
        firebaseAnalyticsLogLogin,
        firebaseAnalyticsLogShare,
        firebaseAnalyticsLogScreenView,
        firebaseAnalyticsResetAnalyticsData,
        firebaseAnalyticsSetCurrentScreen,
      ];

  static List<TetaActionType> get firebaseMessagingActions => [
        firebaseMessagingSubscribeToTopic,
        firebaseMessagingUnsubscribeFromTopic,
      ];

  static List<TetaActionType> get supabaseAuthActions => [
        supabaseSignInWithCredentials,
        supabaseSignInWithProvider,
        supabaseSignUpWithCredentials,
      ];

  static List<TetaActionType> get supabaseDBActions => [
        supabaseDelete,
        supabaseInsert,
        supabaseUpdate,
        // supabaseOnAll,
        // supabaseOnDelete,
        // supabaseOnInsert,
        // supabaseOnUpdate,
      ];

  static List<TetaActionType> get supabaseFunctionsActions => [
        supabaseFunctionInvoke,
      ];

  static List<TetaActionType> get supabaseStorageActions => [
        supabaseStorageDelete,
        supabaseStorageUpload,
      ];

  static List<TetaActionType> get airtableActions => [
        airtableDelete,
        airtableInsert,
        airtableUpdate,
      ];

  static List<TetaActionType> get revenueCatActions => [
        revenueCatBuy,
        revenueCatRestore,
      ];

  static List<TetaActionType> get qonversionActions => [
        qonversionBuy,
        qonversionRestore,
      ];

  static List<TetaActionType> get braintreeActions => [
        braintreeBuy,
      ];

  static List<TetaActionType> get webViewActions => [
        webViewGoBack,
        webViewGoForward,
        webViewReload,
        webViewNavigateTo,
      ];

  static List<TetaActionType> get audioPlayerActions => [
        audioPlayerLoopOne,
        audioPlayerLoopAll,
        audioPlayerLoopOff,
        audioPlayerPause,
        audioPlayerPlay,
        audioPlayerNextTrack,
        audioPlayerPreviousTrack,
        audioPlayerReload,
      ];

  static List<TetaActionType> get googleMapsActions => [
        googleMapsUpdateDeviceLiveLocation,
        googleMapsReloadData,
        googleMapsSetCameraPosition
      ];

  static List<TetaActionType> get cameraActions => [
        cameraAlwaysFlash,
        cameraAutoFlash,
        cameraOffFlash,
        cameraStartRecoring,
        cameraStopRecording,
        cameraSwitchCamera,
        cameraTakePhoto,
        cameraTorchFlash,
      ];

  static List<TetaActionType> get stripeActions => [
        stripeCheckout,
        stripeAddListItemToCart,
        stripeCartBuyAll,
        stripeCartRemoveListItem,
        stripeShowReceipt,
      ];
}
