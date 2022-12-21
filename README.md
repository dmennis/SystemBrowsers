# About
SystemBrowsers is a native SwiftUI iPad/iPhone application to showcase native smart card support when embedding Apple system browsers into a native app.

The goal of this app was to test the three main iOS/iPadOS system browsers ([WKWebView](https://developer.apple.com/documentation/webkit/wkwebview), [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller), and [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession)) to see if and how they each interact with an external smart card such as the YubiKey, specifically for client certificate-based authentication. Or, do they require a 3rd party middleware solution such as [Yubico Authenticator app for iOS/iPad](https://apps.apple.com/us/app/yubico-authenticator/id1476679808) or additional code changes to interact with a connected smart card. 

## Note on dependency
This app has one dependency on [BetterSafariView](https://github.com/stleamist/BetterSafariView) in order to reduce the boilerplate code needed to launch and display the system browser(s).

## iPad with USB-C Specifically
As of iPadOS 16.1, the system natively sees and can interact with a connected YubiKey as a Smart Card over USB-C. The native CCID/SmartCard libraries are built into SFSafariViewController, ASWebAuthenticationSession, and the stand-alone Safari browser app. The WKWebview as an embedded system browser DOES NOT have the native libraries to identify a connected USB-C YubiKey as a smart card on an iPad, as demonstrated by this app.

## Result Summary
**WKWebView** [NOT WORKING] - WKWebView not support the default native interaction with the YubiKey over USB-C on an iPad. It does not appear to recognize the inserted YubiKey as a smart card by default. On an iPhone w/Lightning connector, the WKWebView also does not see a connected YubiKey 5Ci (even after smart card support was added in iOS 16). In addition, the WKWebView does not have the ability to read the iOS Keychain for any saved certificates. Developers can modify their apps by adding the CryptoTokenKit framework to read the save tokens, present those tokens as certificates and utilize a 3rd party middleware app like Yubico Authenticator to complete authentication.

**ASWebAuthenticationSession** [WORKING] - For iPadOS 16.1 with USB-C --> Identifies the inserted YubiKey over USB-C as a smart card, browser prompts for the PIV pin, and successfully signs. For iPhone (16+) with Lightning connector, this browser supports the Yubico Authenticator middleware app by first finding and displaying the saved certificates (public keys only) within the iOS Keychain and then displaying them to the user.

**SFSafariViewController** [WORKING] - For iPadOS 16.1 with USB-C --> Identifies the inserted YubiKey over USB-C as a smart card, browser prompts for the PIV pin, and successfully signs. For iPhone (16+) with Lightning connector, this browser supports the Yubico Authenticator middleware app by first finding and displaying the saved certificates (public keys only) within the iOS Keychain and then displaying them to the user.

## Assets
![SFSafariViewController - iPhone Xr iOS 16.1](/assets/videos/SFSafariViewController-iOS16.gif)
