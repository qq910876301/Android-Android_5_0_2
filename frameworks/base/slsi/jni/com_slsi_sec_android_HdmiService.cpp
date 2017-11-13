#define LOG_TAG "HDMIStatusService"

#include "jni.h"
#include "JNIHelp.h"
#include <cutils/log.h>

#define LOG_NDEBUG 0
#include "SecHdmiClient.h"

namespace android {

/*
 * Class:     com_slsi_sec_android_HdmiService
 * Method:    setHdmiCableStatus
 * Signature: (I)V
 */
static void com_slsi_sec_android_HdmiService_setHdmiCableStatus
  (JNIEnv *env, jobject obj, jint i)
{
    int result = 0;
    ALOGD("%s HDMI status: %d", __func__, i);
    (SecHdmiClient::getInstance())->setHdmiCableStatus(i);
}

/*
 * Class:     com_slsi_sec_android_setHdmiMode
 * Method:    setHdmiMode
 * Signature: (I)V
 */
static void com_slsi_sec_android_HdmiService_setHdmiMode
  (JNIEnv *env, jobject obj, jint i)
{
    ALOGD("%s HdmiMode: %d", __func__, i);
    (SecHdmiClient::getInstance())->setHdmiMode(i);
}

/*
 * Class:     com_slsi_sec_android_setHdmiResolution
 * Method:    setHdmiResolution
 * Signature: (I)V
 */
static void com_slsi_sec_android_HdmiService_setHdmiResolution
(JNIEnv *env, jobject obj, jint i)
{
    int result = 0;
    ALOGD("%s HdmiResolution: %d", __func__, i);
    (SecHdmiClient::getInstance())->setHdmiResolution(i);
}

/*
 * Class:     com_slsi_sec_android_setHdmiHdcp
 * Method:    setHdmiHdcp
 * Signature: (I)V
 */
static void com_slsi_sec_android_HdmiService_setHdmiHdcp
(JNIEnv *env, jobject obj, jint i)
{
    ALOGD("%s HdmiHdcp: %d", __func__, i);
    (SecHdmiClient::getInstance())->setHdmiHdcp(i);
}

/*
 * Class:     com_slsi_sec_android_HdmiService
 * Method:    initHdmiService
 * Signature: ()V
 */
static void com_slsi_sec_android_HdmiService_initHdmiService
  (JNIEnv *env, jobject obj)
{
    ALOGI("%s ", __func__);
    //(SecHdmiClient::getInstance())->init();
}

static jint com_slsi_sec_android_HdmiService_setHdmiOverScan
  (JNIEnv *env, jobject obj, jint width, jint height, jint left, jint top)
{
    ALOGI("%s width:%d, height: %d, left: %d, top: %d", __func__, width, height, left, top);
    return (SecHdmiClient::getInstance())->setHdmiOverScan(width, height, left, top);
}

static jint com_slsi_sec_android_HdmiService_getHdmiXOverScan
  (JNIEnv *env, jobject obj)
{
    ALOGI("%s ", __func__);
    jint x=-1, y=-1;
    (SecHdmiClient::getInstance())->getHdmiOverScan(&x, &y);
    return x;
}

static jint com_slsi_sec_android_HdmiService_getHdmiYOverScan
  (JNIEnv *env, jobject obj)
{
    ALOGI("%s ", __func__);
    jint x=-1, y=-1;
    (SecHdmiClient::getInstance())->getHdmiOverScan(&x, &y);
    return y;
}

static JNINativeMethod gMethods[] = {
    {"setHdmiCableStatus", "(I)V", (void*)com_slsi_sec_android_HdmiService_setHdmiCableStatus},
    {"setHdmiMode", "(I)V", (void*)com_slsi_sec_android_HdmiService_setHdmiMode},
    {"setHdmiResolution", "(I)V", (void*)com_slsi_sec_android_HdmiService_setHdmiResolution},
    {"setHdmiHdcp", "(I)V", (void*)com_slsi_sec_android_HdmiService_setHdmiHdcp},

    {"setHdmiOverScan", "(IIII)I", (void*)com_slsi_sec_android_HdmiService_setHdmiOverScan},
    {"getHdmiXOverScan", "()I", (void*)com_slsi_sec_android_HdmiService_getHdmiXOverScan},
    {"getHdmiYOverScan", "()I", (void*)com_slsi_sec_android_HdmiService_getHdmiYOverScan},

    {"initHdmiService", "()V", (void*)com_slsi_sec_android_HdmiService_initHdmiService},
};

int register_com_samsung_sec_android_HdmiService(JNIEnv* env)
{
     jclass clazz = env->FindClass("com/slsi/sec/android/HdmiService");

     if (clazz == NULL)
     {
         ALOGE("Can't find com/slsi/sec/android/HdmiService");
         return -1;
     } else {
        ALOGD("%s found com/slsi/sec/android/HdmiService ok", __func__);
     }

     return jniRegisterNativeMethods(env, "com/slsi/sec/android/HdmiService",
                                     gMethods, NELEM(gMethods));
}

} /* namespace android */
