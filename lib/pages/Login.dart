// Login page of the app.
// authenticate user using JWT from backend.
// Needs 2 form fields, username and password.
// User can also press Browse without logging in button to be able to browse everything without logging in.

import 'package:flutter/material.dart';
import 'package:properly_made_nft_market/Decoration/AnimatedGradient.dart';
import "package:properly_made_nft_market/Decoration/LoginDecoration.dart" as decoration;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:properly_made_nft_market/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: [Positioned(child:
          AnimatedGradient(),
          ),
            Positioned(child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [Padding(padding: const EdgeInsets.only(top: 100),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                    ),
                    items: decoration.imageList.map((e) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(e,
                                width: 1050,
                                height: 350,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        )
                    ).toList(),
                  ),
                ),
                  Padding(padding: const EdgeInsets.only(top: 30),
                    child: Text("Login",
                      style: decoration.mainTextStyle,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 30),
                    child: Text("Login",
                      style: decoration.mainTextStyle,
                    ),

                  ),
                  ElevatedButton(
                    onPressed: () => loginUsingMetamask(context),
                    child: const Text("Connect with metamask"),
                  )

                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
