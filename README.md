# About
SystemBrowsers is a native SwiftUI iPad/iPhone application to showcase native smart card support when embedding Apple system browsers into a native app.

The goal of this app was to test the three main iOS/iPadOS system browsers:

- [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)
- [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)
- [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession)

Goal: Embedding each system browswer into a native app to see they interact with a connected external smart card such as the YubiKey, specifically for client certificate-based authentication. If the browsers don't interact with the connected smart card natively, do they function with a 3rd party middleware solution such as [Yubico Authenticator app for iOS/iPad](https://apps.apple.com/us/app/yubico-authenticator/id1476679808) or is additional code changes neccessary to interact with a connected smart card?

# Note on dependency
This app has one Swift package dependency on [BetterSafariView](https://github.com/stleamist/BetterSafariView) in order to reduce the boilerplate code needed to launch and display the system browser(s).

# Getting Started
1. Clone this repository
2. Open `SystemBrowsers.xcodeproj` into Xcode.
3. Build/Run

# Result Summary
### **WKWebView** `[NOT WORKING]`
On iPad with USB-C, WKWebView does not support the default native interaction with a USB-C connected YubiKey. It does not appear to recognize the inserted YubiKey as a smart card by default. 

On an iPhone or iPad w/Lightning connector, the WKWebView also does not see a connected YubiKey 5Ci (even after smart card support was added in iOS 16). In addition, the WKWebView does not have the ability to read the iOS Keychain for any saved certificates. Developers can modify their apps by adding the CryptoTokenKit framework to read save tokens, present those tokens as certificates, and rely on a 3rd party middleware app like Yubico Authenticator to complete authentication.

### **ASWebAuthenticationSession** `[WORKING]`

For iPadOS 16.1+ with USB-C --> Identifies the inserted YubiKey over USB-C as a smart card, browser prompts for the PIV pin, and successfully signs with no additional app code required. 

For iPhone/iPad (16+) with Lightning connector --> Browser has the ability to see certificates/tokens on the Keychain and present to the user but requires a 3rd party middleware app like the Yubico Authenticator to be installed to interact directly with the connected YubiKey. In this case, the Yubico Authenticator will interact with a YubiKey over NFC, if available.

### **SFSafariViewController** `[WORKING]`

For iPadOS 16.1 with USB-C --> Identifies the inserted YubiKey over USB-C as a smart card, browser prompts for the PIV pin, and successfully signs with no additional app code required. 

For iPhone/iPad (16+) with Lightning connector --> Browser has the ability to see certificates/tokens on the Keychain and present to the user but requires a 3rd party middleware app like the Yubico Authenticator to be installed to interact directly with the connected YubiKey. In this case, the Yubico Authenticator will interact with a YubiKey over NFC, if available. 

# Demo
![SFSafariViewController - iPhone Xr iOS 16.1](/assets/videos/SFSafariViewController-iOS16.gif)
