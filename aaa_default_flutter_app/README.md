# aaa_default_flutter_app


### idk
source = https://youtu.be/8sAyPDLorek?si=Fcgb_g52Cz4yF-YE&t=486

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### work-arounds
1. on linux -- using the android emulator target fails.
2. on linux -- using the web/chrome emulator target succeeds. 
3. vscode config 
  - PRE: install later version of gradle (v8+) - add gradle to path - remove old gradle from path
  - PRE: in vscode  , (explicitly and manually) configure the openjdk version that vscode must use

    - ~/.config/Code/User/settings.json   -- same snippet as image above, but in text
    - note: replace {{home}} with your actual value of ${HOME}  (e.g. /home/myusrename)
    ```json

    ...  
      "java.configuration.runtimes": [

            {"name":"JavaSE-18",
            "path":"{{home}}/java/openjdk18" ,
            "sources" : "{{home}}/java/openjdk18/src/openjdk18-sources.zip",
            "javadoc" : "{{home}}/java/openjdk18/docs/api",
            "default":  true
            },

            {"name":"JavaSE-23",
            "path":"{{home}}/java/openjdk23" ,
            "default":  false
            }
        ],
        "java.import.gradle.java.home":"{{home}}/java/openjdk18",
    ...


    ```