# hyper

Hyper makes it easy to build HTML using Dart. It's intentionally kept simple, and produces nothing but strings of HTML.

## Usage

```dart
import 'package:hyper/hyper.dart';

main() {
  // Create elements using `hyper`, a tag name, attributes, and a list of
  // child elements.
  var header = hyper(
    'h1',
    attrs: {'class': 'header'},
    children: [
      // `t` produces a special element that does not use a tag. Use it for
      // text nodes.
      t('Hello, world!'),
    ],
  );
  print(header); // <h1 class="header">Hello, world!</h1>
}
```

### Hyper Elements

`hyper` also has an optional export that includes all of the HTML tags as individual functions. This makes it a little easier to ensure that you're not doing something silly like passing a child element to an `img` tag.

```dart
import 'package:hyper/hyper.dart';
import 'package:hyper/elements.dart' as h;

main() {
  var header = h.h1(
    attrs: {
      'class': 'header',
    },
    children: [
      t('Hello, world!'),
    ],
  );
  print(header); // <h1 class="header">Hello, world!</h1>

  // This won't even compile!
  // var invalidElement = h.img(children: [t('Not gonna work!')]);
}
```

## What this package isn't

`hyper` is a tool to make it easier to generate static HTML. It doesn't provide anything exciting like virtual DOM or event listeners. It's simple, and just generates a text HTML string.

## Prior Art

`hyper` was heavily inspired by [HyperScript](https://github.com/hyperhype/hyperscript).