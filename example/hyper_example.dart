import 'package:hyper/hyper.dart';
import 'package:hyper/elements.dart' as h;

main() {
  // Hyper can be used to compose full HTML documents.
  var fullHtmlDoc = hyper('html', children: [
    hyper('head', children: [
      hyper('title', children: [
        t('Hello, world!'),
      ])
    ]),
    hyper('body', children: [
      hyper(
        'h1',
        attrs: {'class': "greeting"},
        children: [
          t('Hello from Hyper!'),
        ],
      )
    ]),
  ]);
  print(fullHtmlDoc);
  // <html>
  //   <head>
  //     <title>Hello, world!</title>
  //   </head>
  //   <body>
  //     <h1 class="greeting">Hello from Hyper!</h1>
  //   </body>
  // </html>

  // You can also use the Elements package to make things a bit easier.
  var header = h.header(
    attrs: {'class': 'heading'},
    children: [
      h.h1(children: [
        // Text nodes can be created using t.
        t('Title'),
      ])
    ],
  );
  print(header);
  // <header class="heading">
  //   <h1>Title</h1>
  // </header>

  // Using the Elements package also makes sure you don't accidentally pass
  // children to a void element. This won't even compile!
  // var invalidElement = h.img(children: [t('Not gonna work!')]);

  // You can also compose Elements together.
  Element container({List<Element> children}) {
    return h.div(attrs: {'class': 'container'}, children: children);
  }

  Element userProfile(String username, String petsName) {
    return h.div(
      attrs: {'class': 'userProfile'},
      children: [
        h.h2(
          attrs: {'class': 'username'},
          children: [
            t(username),
          ],
        ),
        h.p(
          attrs: {'class': 'petsName'},
          children: [
            t("Parent to: $petsName"),
          ],
        ),
      ],
    );
  }

  var userProfiles = container(
    children: [
      userProfile('dstaley', 'Jpeg'),
      userProfile('paddycarver', 'Roxy'),
    ],
  );
  print(userProfiles);
  // <div class="container">
  //   <div class="userProfile">
  //     <h2 class="username">dstaley</h2>
  //     <p class="petsName">Parent to: Jpeg</p>
  //   </div>
  //   <div class="userProfile">
  //     <h2 class="username">paddycarver</h2>
  //     <p class="petsName">Parent to: Roxy</p>
  //   </div>
  // </div>
}
