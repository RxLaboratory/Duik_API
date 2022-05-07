![META](authors:Nicolas "Duduf" Dufresne;license:GNU-FDL;copyright:2022;updated:2022/05/07)

# Introduction to the Duik API

*Duik* is a comprehensive character rigging and animation tool set for After Effects. It is an end-user tool, which sits in its own panel in the UI of After Effects.

To make it easier for people with basic scripting abilities to use Duik in their own scripts, automation, auto-rigs, etc, *Duik* also comes with an easy-to-use API. It may also be very useful to advanced developpers though, as it also includes a lot of low-level methods and a very comprehensive scripting framework for After Effects and more generally for Adobe Applications.

It is written in *[ExtendScript](http://extendscript.docsforadobe.dev/)* with the standard *[After Effects API](http://ae-scripting.docsforadobe.dev/)*.

If you've never written any script for After Effects, you may start by learning how to create advanced *[expressions](http://ae-expressions.docsforadobe.dev/)* first, as they use the same language and an API very close to the *[After Effects scripting API](http://ae-scripting.docsforadobe.dev/)*. Then you'll be able to write your first scripts.

## Useful resources

These are a few links you may always keep at hand when writing scripts for *After Effects* using the *Duik API*.

- **[Javascript Tools Guide (ESTK)](http://extendscript.docsforadobe.dev/)**: this is the documentation and reference for all scripts written using *ExtendScript* for *Adobe* applications.
- **[After Effects Expressions Documentation](http://ae-expressions.docsforadobe.dev/)**: the complete documentation about After Effects expressions.
- **[After Effects Scripting Guide](http://ae-scripting.docsforadobe.dev/)**: this is the documentation and comprehensive reference of the *After Effects Scripting API* using *ExtendScript*.
- **[duik.rxlab.io](http://duik.rxlab.io)**: the complete documentation about this *Duik API* (the one you're currently reading).
- **[Duik API reference](http://duik.rxlab.io/reference)**: the comprehensive *Duik API reference*. Keep it under your pillow.

## Getting started

### Download the API

The API and its documentation can be downloaded from [RxLaboratory](http://rxlaboratory.org), [here](https://rxlaboratory.org/tools/duik-angela/), or from a dedicated [*Github* Repository](https://github.com/RxLaboratory/Duik_API), [here](https://github.com/RxLaboratory/Duik_API).

### Include it in your script

Just save the two files `Duik_api.jsxinc` and `DuAEF_Duik_api.jsxinc` in the folder where you're working and writing your own script.

- `DuAEF_Duik_api.jsxinc` is the complete API, including all dependencies. This is the one you should use by default.

- `Duik_api.jsxinc` includes only the *Duik API* without any dependencies. You'll have to include dependencies by yourself; The list of these dependencies can be found in the [API reference](http://duik.rxlab.io/reference) (see *Requires* on the linked page). At the time we're writing this documentation, they're *DuAEF*, [*DuGR*](https://rxlaboratory.org/tools/dugr/) and [*DuIO*](https://rxlaboratory.org/tools/duio/). You may use this file if you plan to combine several different API using *DuAEF*, to be sure to include it only once.

#### Using only Duik (and DuGR and DuIO)

If you're only needing the Duik API, and perhaps the DuGR API or the DuIO API too, which are included in Duik, you just have to include `DuAEF_Duik_api.jsxinc` at the beginning of your own script.

Here's an example.

```js
// Encapsulate everything to avoid global variables!
// thisObj is either undefined (for stand alone script) or the panel containing the ui (for ScriptUI panel)
(function(thisObj)
{
     // If you only need Duik, just include DuAEF_Duik_api at the beginning
     #include "DuAEF_Duik_api.jsxinc";
     
```

#### Combining the Duik API with other APIs and DuAEF

If you're going to include APIs other than Duik (or DuGR and DuIO which are already included in Duik), you'll need to include everything separately to be sure that all frameworks are included only once. In this case, include `Duik_api.jsxinc` and the other APIs at the beginning of your script.

Here's an example:

```js
// Encapsulate everything to avoid global variables!
// The parameter is either undefined (stand alone script) or the panel containing the ui (ScriptUI)
(function(thisObj)
{
     // If you need to combine Duik and other APIs like DuIO or DuGR
     // Include DuAEF first, and then stand-alone APIs
     #include "DuAEF.jsxinc";
     #include "DuGR_api.jsxinc";
     #include "DuIO_api.jsxinc";
     #include "Duik_api.jsxinc";

     // Now you can also include any other API which also depends on DuAEF or one of the above APIs
     #include "another_API.jsxinc"
```

#### Initialisation

Just after you've included the API, you have to run the `DuAEF.init()` method, to setup the framework:

```js
     // Running the init() method of DuAEF is required to setup everything properly.
     DuAEF.init( "YourScriptName", "1.0.0", "YourCompanyName" );
```

***DuAEF*** is the *Duduf After Effects Framework*, and is used by the Duik API. It is a (big) set of objects and methods to ease scripting for *After Effects*.

Once *DuAEF* has bee initialised, you can set a few parameters to improve the UX:

```js
     // These info can be used by the framework to improve UX, but they're all optional
     DuESF.chatURL = 'http://chat.rxlab.info'; // A link to a live-chat server like Discord or Slack...
     DuESF.bugReportURL = 'https://github.com/RxLaboratory/DuAEF_Dugr/issues/new/choose'; // A link to a bug report form
     DuESF.aboutURL = 'http://rxlaboratory.org/tools/duik'; // A link to the webpage about your script
     DuESF.docURL = 'http://duik.rxlab.guide'; // A link to the documentation of the script
     DuESF.scriptAbout = 'Duik: The comprehensive rigging and animation tool set'; // A short string describing your script
     DuESF.companyURL = 'https://rxlaboratory.org'; // A link to your company's website
     DuESF.rxVersionURL = 'http://api.rxlab.io' // A link to an RxAPI server to check for updates
```

***DuESF*** here refers to the *Duduf ExtendScript Framework*, which is used by *DuAEF* and the *Duik API*. It is another set of objects and methods to ease scripting for any *Adobe* application.

Now everything is ready, you can add your own methods, and build the UI. For this, you can use *DuScriptUI*, a set of objects and methods to easily build nice UI with ExtendScript and its ScriptUI objects:

```js     
     // This will be our main panel
     var ui = DuScriptUI.scriptPanel( thisObj, true, true, new File($.fileName) );
     ui.addCommonSettings(); // Automatically adds the language settings, location of the settings file, etc

     DuScriptUI.staticText( ui.settingsGroup, "Hello world of settings!" ); // Adds a static text to the settings panel

     DuScriptUI.staticText( ui.mainGroup, "Hello worlds!" ); // Adds a static text to the main panel
     
     // When you're ready to display everything
     DuScriptUI.showUI(ui);
```

**If, and only if** you're not calling the `DuScriptUI.showUI(ui)` method, because you don't use *DuScriptUI* to build your UI for example, you have to call `DuAEF.enterRunTime()` before running any other function.

```js  
     // Note that if you don't have a UI or if you don't use DuScriptUI to show it,
     // you HAVE TO run this method before running any other function:
     DuAEF.enterRunTime();
```

Don't forget to close the anonymous function we've created at the beginning to avoid global variables, and pass `this` so the script can be built in its own panel, if any.

```js
})(this);
```

#### Complete example

```js
// Encapsulate everything to avoid global variables!
// thisObj is either undefined (for stand alone script) or the panel containing the ui (for ScriptUI panel)
(function(thisObj)
{
     // If you only need Duik, just include DuAEF_Duik_api at the beginning
     #include "DuAEF_Duik_api.jsxinc";
     
     // Running the init() method of DuAEF is required to setup everything properly.
     DuAEF.init( "YourScriptName", "1.0.0", "YourCompanyName" );

     // These info can be used by the framework to improve UX, but they're all optional
     DuESF.chatURL = 'http://chat.rxlab.info'; // A link to a live-chat server like Discord or Slack...
     DuESF.bugReportURL = 'https://github.com/RxLaboratory/DuAEF_Dugr/issues/new/choose'; // A link to a bug report form
     DuESF.aboutURL = 'http://rxlaboratory.org/tools/duik'; // A link to the webpage about your script
     DuESF.docURL = 'http://duik.rxlab.guide'; // A link to the documentation of the script
     DuESF.scriptAbout = 'Duik: The comprehensive rigging and animation tool set'; // A short string describing your script
     DuESF.companyURL = 'https://rxlaboratory.org'; // A link to your company's website
     DuESF.rxVersionURL = 'http://api.rxlab.io' // A link to an RxAPI server to check for updates

     // === Add your own functions, develop your script here ===

     // And build the UI, for example

     // This will be our main panel
     var ui = DuScriptUI.scriptPanel( thisObj, true, true, new File($.fileName) );
     ui.addCommonSettings(); // Automatically adds the language settings, location of the settings file, etc

     DuScriptUI.staticText( ui.settingsGroup, "Hello world of settings!" ); // Adds a static text to the settings panel

     DuScriptUI.staticText( ui.mainGroup, "Hello worlds!" ); // Adds a static text to the main panel
     
     // When you're ready to display everything
     DuScriptUI.showUI(ui);

     // /!\
     // Note that if and only if you don't have a UI or if you don't use DuScriptUI to show it,
     // you HAVE TO run this method before running any other function:
     // DuAEF.enterRunTime();
})(this);
```

## Using Duik features, the High-level Duik API

Using basic Duik features in your script is pretty easy. Most of theses features are simple methods, sorted in a few namespaces to keep things tidy.

For example, to run the *arm* auto-rig, just run the `arm` method from the `Rig` namespace of `Duik`:

```js
    // Automatically rig the selected bones as an arm
    Duik.Rig.arm();

    // Or you can pass an array of layers to the rigging methods
    Duik.Rig.leg( someLayers );
```

As another example, you can also add a wiggle effect to the selected properties, or some properties of your choice.

The `wiggle` method is in the `Automation` namespace of `Duik`: 

```js
    // Add a Wiggle control with default options to the selected properties
    Duik.Automation.wiggle();

    // Or you can set some parameters
    // 1. Separate dimensions
    // 2. Add one control per property (instead  of a single control for all of them)
    // 3. An array of properties to setup
    Duik.Automation.wiggle( true, true, someProperties );
```

Of course, all these methods are fully documented; you can read the reference of [the `Duik` namespace](https://duik.rxlab.io/reference/Duik.html) to learn all of them.

This `Duik` namespace is divided in a few other categories to make things easier to find and use:

- [**`Duik.Animation`**: The animator's toolkit](https://duik.rxlab.io/reference/Duik.Animation.html) (copy/paste animation, tween, snapKeys...)
- [**`Duik.Automation`**: The lazy animator's toolkit.](https://duik.rxlab.io/reference/Duik.Automation.html) (NLA, motionTrail, wiggle, random, walk cycle...)
- [**`Duik.Bone`**: Bone and armatures related tools.](https://duik.rxlab.io/reference/Duik.Bone.html) (leg, arm, bake...)
- [**`Duik.Camera`**: Camera toolkit.](https://duik.rxlab.io/reference/Duik.Camera.html) (frame, rig, twoDCamera...)
- [**`Duik.CmdLib`**: The Duik command line library.](https://duik.rxlab.io/reference/Duik.Camera.html) This is a specific namespace used by the *Duik Command Line* panel.
- [**`Duik.Constraint`**: Constraints for rigging bones and layers.](https://duik.rxlab.io/reference/Duik.Constraint.html) (twoLayerIK, oneLayerIK, bezierIK, orientation, parentAcrosscomp...)
- [**`Duik.Controller`**: Controller related tools.](https://duik.rxlab.io/reference/Duik.Controller.html) (create, bake...)
- [**`Duik.Layer`**: Layer related tools.](https://duik.rxlab.io/reference/Duik.Layer.html) (setLimbName, setCharacterName, select, sanitizeName...)
- [**`Duik.Pin`**: Pin related tools.](https://duik.rxlab.io/reference/Duik.Pin.html) (create, linkPathToLayers, linkPuppetPinsToLayers, addPins...)
- [**`Duik.Rig`**: (Auto)Rigging tools.](https://duik.rxlab.io/reference/Duik.Rig.html) (auto, arm, leg, fin, wing...)
- [**`Duik.Tool`**: Miscellaneous tools.](https://duik.rxlab.io/reference/Duik.Tool.html) (cropPrecompositions, editExpression...)

## DuAEF, After Effects Framework

[DuAEF](https://duik.rxlab.io/reference/DuAEF.html) includes a lot of useful methods to help After Effects Scripting, and a few specific objects. They're all objects and namespaces which name start with *DuAE*.

Example:

```js
    // Get the active composition
    var comp = DuAEProject.getActiveComp();
    // May be null if there's no active comp.
    if (comp) {
        // Add a 20 px wide null layer
        // Note that DuAEF uses a shape layer as null layer,
        // so it doesn't pollute the "Solids" folder of the project.
        var null = DuAEComp.addNull( comp, 20 );
    }
```

Some objects are available to make things easier. Especially with properties (to work around the dreaded *invalid object* from AE's strange behaviour).

```js
    var comp = DuAEProject.getActiveComp();
    var layer = comp.layer(1);
    var transform = new DuAEProperty( layer.transform )
    // Replaces some text in all expressions of all properties in the "transform" PropertyGroup
    transform.replaceInExpressions("before", "after");

    // We can also select all keyframes for example
    transform.selectKeys();

    // Or change the interpolation for all keyframes
    transform.setInterpolation( KeyframeInterpolationType.BEZIER );
```

!!! note
    In the future, namespaces like `DuAEComp` may be also available as wrappers, objects, like `DuAEProperty`.

## DuESF, ExtendScript Framework

[DuESF](https://duik.rxlab.io/reference/DuESF.html) extends the default ExtendScript framework with useful objects and methods.

For example, a set is available to ease the creation of UIs.

```js
    // This will be our main panel
     var ui = DuScriptUI.scriptPanel( thisObj, true, true, new File($.fileName) );
     ui.addCommonSettings(); // Automatically adds the language settings, location of the settings file, etc

     DuScriptUI.staticText( ui.settingsGroup, "Hello world of settings!" ); // Adds a static text to the settings panel

     DuScriptUI.staticText( ui.mainGroup, "Hello worlds!" ); // Adds a static text to the main panel
     DuScriptUI.button( ui.mainGroup, "A Button"); // Adds a button, which can have an icon
     
     // When you're ready to display everything
     DuScriptUI.showUI(ui);
```

It also includes a lot of lower level objects and methods. Here are some examples.

```js
    // COLORS
    var red = new DuColor([1, 0, 0, 1]);
    // alerts "#ff0000"
    alert(red.hex); 
    // Get a darker red
    var darkerRed = red.darker();
    // You can also create a color from hex
    var blue = DuColor.fromHex("#0000ff");
    // Or use a predefined color
    var aeBlue = DuColor.Color.AFTER_EFFECTS_BLUE;

    // MATH
    // Clamp a value (works also with a set of values)
    var clamped = DuMath.clamp( aValue, -5, 5);
    // Linear interpolation (or extrapolation)
    var interpolation = DuMath.linear( aValue, 0, 1, 12, 27);
    
    // Some useful functions are available
    var gauss = DuMath.gaussian( aValue );
    var randomValue = DuMath.gaussRandom( 0, 10 );

    // FILES

    // Get the first line of a text file
    var info = DuFile.readFirstLine( "C:/a/path/file.txt" );
    // Save a JS object to a JSON file
    var obj = { one: "A text", two: [ "an", "array"] };
    DuFile.saveJSON(obj, "C:/a/path/file.json" );
```

