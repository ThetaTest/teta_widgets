// ignore_for_file: public_member_api_docs

enum ActionSupabaseAuth {
  signInWithCredential,
  signUp,
  signInWithApple,
  signInWithAzure,
  signInWithBitbucket,
  signInWithDiscord,
  signInWithFacebook,
  signInWithGitHub,
  signInWithGitLab,
  signInWithGoogle,

  //signInWithLinkedin,
  //signInWithNotion,
  signInWithTwitch,
  signInWithTwitter,
  signInWithSlack,
  signInWithSpotify,
  //signInWithWorkOS,
  //signInWithZoom,
  requestOtp,
  signUpWithPhone,
  signInWithPhone,
  signOut,
}

enum ActionSupabaseDB {
  insert,
  update,
  delete,

}

enum ActionSupabaseStorage { 
  upload, 
  remove,
  createBucket,
  getBucket,
  listBuckets,
  updateBucket,
  deleteBucket,
  emptyBucket,
  downloadFile,
  listAllFilesInBucket,
  update

   }

enum ActionSupabaseFunctions {
  invoke,
}
