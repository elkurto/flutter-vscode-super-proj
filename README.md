# flutter-vscode-super-proj
project that contains flutter example




#### nna12_row_widget
- Usage of rows and columns - marginal styling
![nna12_row_widget](./zzzdoc/nna12_row_widget.000.png)


#### nna14_expanded_widget
- Fill left-over space with a background image
```
  ...
      Expanded(
            // note: fill the remaining background with a bg-image
            //    and adjust the image
            child: Image.asset(
              'assets/img/coffee_bg.jpg',
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
  ...
```  
![nna14_expanded_widget.000.png](./zzzdoc/nna14_expanded_widget.001.png)        

#### nna15_buttons 
- add buttons and custom styles coffee_prefs.dart
https://docs.flutter.dev/ui/widgets/material#actions

![nna15_button.000.png](./zzzdoc/nna15_button.000.png)


#### nna16_stateful_widget and nna17_conditional_rendering
- stateful widget and conditional rendering

```
...
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Strength: '),
            Text("$strength  "),

            if (strength == 0) Text("Really Weak"),  // conditional rendering

            for (int i = 0; i < strength; i++)   // conditional rendering
              Image.asset(
                'assets/img/coffee_bean.png',
                width: 25,
                colorBlendMode: BlendMode.multiply,
                color: Colors.brown[100],
              ),
            const Expanded(child: SizedBox(width: 100)),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: increaseStrength,
              child: const Text('+'),
            ),

```
![nna16_stateful_widget.png](./zzzdoc/nna16_stateful_widget.png)


#### nna18_reusable_widget
- Pass parameters to custom widgets to ensure reusablility and DRY principle
- see [class StyledBodyText](./nna18_reusable_widget/lib/styled_body_text.dart)
- see [class StyledButton](./nna18_reusable_widget/lib/styled_button.dart)


![nna18_reusable_widget](./zzzdoc/nna18_reusable_widget.png)


#### nna21_theme_custom
- Define custom theme
- Pass :parameter:"themePrimary" to MaterialApp's ctor

![nna21_theme_custom](./zzzdoc/nna21_theme_custom.000.png)


#### nna22_theme_shared
- Define custom widgets that use the custom theme
- Pass :parameter:"themePrimary" to MaterialApp's ctor

![nna22_theme_shared](./zzzdoc/nna22_theme_shared.000.png)


#### nna23_google_fonts
A. Using google fonts
  1. import google_fonts as a dependency in `pubspec.yml` <br/>
  ```bash
    flutter pub add google_fonts
  ```

  2. import google_fonts and use the factory method in a widget.
  ```dart
  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart'; // 2. import googe_fonts

  class StyledText extends StatelessWidget {
    const StyledText(this.text, {super.key});

    final String text;

    @override
    Widget build(BuildContext context) {
      // 3. use GoogleFonts factory methos in :attr:"style"
      return Text(
        text, // --
        style: GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
      );
    }
  }
  ```
  ![nna23_google_font.000.png](./zzzdoc/nna23_google_font.000.png)


#### nna24_container_gradient
  - Create and use :custom_button_widget:"StyledButton"
  - StyledButton renders a child widget (e.g. StyledHeading('btn-text'))
  - StyledButton has a background-gradient and rounded corners
  - StyledButton uses EdgeInsets for padding
  - StyledButton is really a TextButton that contains a :styled_widget:child

  ```dart
    import 'package:flutter/material.dart';
    import 'package:nna24_container_gradient/theme.dart';

    class StyledButton extends StatelessWidget {
      const StyledButton({super.key, required this.onPressed, required this.child});

      final Function() onPressed;
      final Widget child; // e.g. StyledHeading('Btn-Text')

      @override
      Widget build(BuildContext context) {
        return TextButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //      [start color, end color of gradient]
                colors: [AppColors.primaryColor, AppColors.primaryAccent],
                begin: Alignment.topCenter, // start location of gradient
                end: Alignment.bottomCenter, //  end location of gradient
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: child,
          ),
        );
      }
    }

  ```
  ![nna24_container_gradient](./zzzdoc/nna24_container_gradient.png)


  #### nna25_listview 
    - see [ListView usage : https://docs.flutter.dev/cookbook/lists/long-lists](https://docs.flutter.dev/cookbook/lists/long-lists)
    - :widget:Expanded wraps :widget:ListView  to provide hint to Flutter Layout manager, because ListView is automatically scollable (so ListView has no inherent height).
    - ListView renders a list of items. 

    ```dart
    import 'package:flutter/material.dart';
    import 'package:nna25_listview/shared/styled_text.dart';
    import 'package:nna25_listview/shared/styled_button.dart';

    class Home extends StatefulWidget {
      const Home({super.key});

      @override
      State<Home> createState() => _HomeState();
    }

    class _HomeState extends State<Home> {
      List characters = ['R.Moore', 'D.Lydic', 'J.Oliver', 'J.Carlin', 'J.Klepper', 'K.Knowles'];

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const StyledTitle('Your Characters - :font:kanit'), centerTitle: true),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  // Need `Expanded` to help Flutter's layout manager,
                  // because ListView has unconstrained height.
                  // So :widget:"Expanded" must wrap :child:"ListView"
                  // because "ListView" is automatically scrollable.
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) { // itemBuilder factory-function
                      return Container(
                        color: Colors.grey[800],
                        padding: const EdgeInsets.all(40),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: StyledText(characters[index]),
                      );
                    },
                  ),
                ),
                StyledButton(
                  onPressed: () {
                    // @todo: navigate to the create screen
                  },
                  child: StyledHeading('Create New'),
                ),
              ],
            ),
          ),
        );
      }
    }

    ```

#### nna26_card_widget
  - see [Card - in https://docs.flutter.dev/ui/layout#card](https://docs.flutter.dev/ui/layout#card)
  - Create and use a custom reusable :widget:"CharacterCard"
  - [obsolete] cardTheme in In :file:theme.dart - specify a custom 'cardTheme'.
  - Specified reusable style in :widget:CharacterCard
  
  ```dart
  // file=nna26_card_widget/screens/home_screen/character_card.dart
  import 'package:flutter/material.dart';
  import 'package:nna26_card_widget/theme.dart' show AppColors;

  class CharacterCard extends StatelessWidget {
    const CharacterCard(this.character, {super.key});

    final String character;

    @override
    Widget build(BuildContext context) {
      return Card(
        color: AppColors.secondaryColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          child: Row(children: [Text(character)]),
        ),
      );
    }
  }
  ```
  ![nna26_card_widget](./zzzdoc/nna26_card_widget.000.png)
   
### nna27_icon_button
  - included in code, nna26_card_widget/lib/screens/home_screen/character_card.dart
  - add icon to rhs of each CharacterCard instance
  - for more icons - see https://fonts.googe.com/icons

  ![nna27_icon_button](./zzzdoc/nna27_icon_button.png)

### nnna35_data_model_static
  - finish section on data model (culmination of lesson-26..lesson-35)
  - create a working app with character screen and proper layout.

  ![nna35_data_model_static](./zzzdoc/nna35_data_model_static.png)