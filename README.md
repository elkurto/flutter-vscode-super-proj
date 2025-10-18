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