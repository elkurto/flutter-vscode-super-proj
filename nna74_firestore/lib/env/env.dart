import 'package:envied/envied.dart';
/**
 * 1. (one-time) install envied dependencies
 *   dart pub add envied dev:envied_generator dev:build_runner
 * 2. define :file:".env" that contains non-secret config items
 *  e.g. not actual config-items
 * 
 * export FIREBASE_OPTIONS_APIKEY=DCzcaeqp-KyGaCtNyc-KQF45301batuNG4
 * export FIREBASE_OPTIONS_APPID=1:112233445566:web:123456789abcdef01234567891234567
 * export FIREBASE_OPTIONS_MESSAGESENDERID=112233445566
 * export FIREBASE_OPTIONS_PROJECTID=nna74firestore
 * export FIREBASE_OPTIONS_AUTHDOMAIN=nna74firestore.firebaseapp.com
 * export FIREBASE_OPTIONS_STORAGEBUCKET=nna74firestore.firebasestorage.app
 *
 * 3. define :class:Env has config-items for both Envied's build_runner 
 *    and :@EnviedFiels: for your app.
 * 
 * 4. use Envied's build_runner to generate the partial file env.g.dart
 *   dart run build_runner build
 * 
 * // for further esoterica refer to the mish-mash docs
 * //   https://pub.dev/packages/envied#obfuscation--encryption
 * // please be prepare to defog and demistify.
 * 
 * 5. import and use Env in :file: {project_root}/lib/firebase_options.dart
 * 
 *   static final FirebaseOptions web = FirebaseOptions(
 *        apiKey: Env.apiKey,
 *        appId: Env.appId,
 *        messagingSenderId: Env.messengerSenderId,
 *        projectId: Env.projectId,
 *        authDomain: Env.authDomain,
 *        storageBucket: Env.storageBucket,
 *      );
 * 
 */

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'FIREBASE_OPTIONS_APIKEY')
  static final String apiKey = _Env.apiKey;

  @EnviedField(varName: 'FIREBASE_OPTIONS_APPID')
  static final String appId = _Env.appId;

  @EnviedField(varName: 'FIREBASE_OPTIONS_MESSAGESENDERID')
  static final String messengerSenderId = _Env.messengerId;

  @EnviedField(varName: 'FIREBASE_OPTIONS_PROJECTID')
  static final String projectId = _Env.projectId;

  @EnviedField(varName: 'FIREBASE_OPTIONS_AUTHDOMAIN')
  static final String authDomain = _Env.authDomain;

  @EnviedField(varName: 'FIREBASE_OPTIONS_STORAGEBUCKET')
  static final String storageBucket = _Env.storageBucket;
}
