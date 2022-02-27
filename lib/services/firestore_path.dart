/*
This class defines all the possible read/write locations from the Firestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String post(String postId) => 'posts/$postId';
  static String user(String userId) => 'users/$userId';
  static String quizRecords(String quizRecordsId) => 'quiz_records/$quizRecordsId';
  static String event(String eventId) => 'events/$eventId';
}
