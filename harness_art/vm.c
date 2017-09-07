#include "vm.h"
#include "android/log.h"

JNIEXPORT void InitializeSignalChain() {

}

JNIEXPORT void ClaimSignalChain() {

}

JNIEXPORT void UnclaimSignalChain() {

}

JNIEXPORT void InvokeUserSignalHandler() {

}

JNIEXPORT void EnsureFrontOfChain() {

}

int init_jvm(JavaVM **p_vm, JNIEnv **p_env) {
  //https://android.googlesource.com/platform/frameworks/native/+/ce3a0a5/services/surfaceflinger/DdmConnection.cpp
  JavaVMOption opt[4];
  opt[0].optionString = "-Djava.class.path=/data/local/tmp/target-app.apk";
  opt[1].optionString = "-agentlib:jdwp=transport=dt_android_adb,suspend=n,server=y";
  opt[2].optionString = "-Djava.library.path=/data/local/tmp";
  opt[3].optionString = "-verbose:jni"; // may want to remove this, it's noisy

  JavaVMInitArgs args;
  args.version = JNI_VERSION_1_4;
  args.options = opt;
  args.nOptions = 4;
  args.ignoreUnrecognized = JNI_FALSE;

  void *libart_dso = dlopen("libart.so", RTLD_NOW);

  if (!libart_dso) {
    return -1;
  }

  JNI_CreateJavaVM_t JNI_CreateJavaVM;
  JNI_CreateJavaVM = (JNI_CreateJavaVM_t) dlsym(libart_dso, "JNI_CreateJavaVM");

  if (!JNI_CreateJavaVM) {
    return -2;
  }

  if (JNI_CreateJavaVM(&(*p_vm), &(*p_env), &args)) {
    return -3;
  }

  return 0;
}
