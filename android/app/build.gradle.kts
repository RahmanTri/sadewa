    import java.util.Properties
    import java.io.FileInputStream

    plugins {
        id("com.android.application")
        id("kotlin-android")
        id("dev.flutter.flutter-gradle-plugin")
    }

    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties()
    println("PATH = ${keystorePropertiesFile.absolutePath}")
    println("EXISTS = ${keystorePropertiesFile.exists()}")
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }

    android {
        namespace = "com.example.sadewa_fe"
        compileSdk = flutter.compileSdkVersion
        ndkVersion = flutter.ndkVersion

        compileOptions {
            sourceCompatibility = JavaVersion.VERSION_17
            targetCompatibility = JavaVersion.VERSION_17
        }

        kotlinOptions {
            jvmTarget = JavaVersion.VERSION_17.toString()
        }

        defaultConfig {
            applicationId = "com.example.sadewa_fe"
            minSdk = flutter.minSdkVersion
            targetSdk = flutter.targetSdkVersion
            versionCode = flutter.versionCode
            versionName = flutter.versionName
        }

        signingConfigs {
            create("release") {
                val storeFilePath = keystoreProperties["storeFile"] as? String
                val storePasswordProp = keystoreProperties["storePassword"] as? String
                val keyAliasProp = keystoreProperties["keyAlias"] as? String
                val keyPasswordProp = keystoreProperties["keyPassword"] as? String

                println("storeFile=$storeFilePath")
                println("storePassword=$storePasswordProp")
                println("keyAlias=$keyAliasProp")
                println("keyPassword=$keyPasswordProp")

                if (storeFilePath != null && storePasswordProp != null && keyAliasProp != null && keyPasswordProp != null) {
                    storeFile = file(storeFilePath)
                    storePassword = storePasswordProp
                    keyAlias = keyAliasProp
                    keyPassword = keyPasswordProp
                } else {
                    throw GradleException("Missing keystore properties, check android/key.properties")
                }
            }
        }

        buildTypes {
            getByName("release") {
                signingConfig = signingConfigs.getByName("release")
                isMinifyEnabled = false
                isShrinkResources = false
                proguardFiles(
                    getDefaultProguardFile("proguard-android.txt"),
                    "proguard-rules.pro"
                )
            }
        }
    }

    flutter {
        source = "../.."
    }

