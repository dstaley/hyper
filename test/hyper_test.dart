import 'package:hyper/hyper.dart';
import 'package:hyper/elements.dart' as h;
import 'package:test/test.dart';

void main() {
  test("simple", () {
    expect(hyper("h1").toString(), "<h1></h1>");
    expect(hyper("h1", children: [t("hello world")]).toString(),
        "<h1>hello world</h1>");
  });

  test("nested", () {
    expect(
        hyper("div", children: [
          hyper("h1", children: [t("Title")]),
          hyper("p", children: [t("Paragraph")])
        ]).toString(),
        "<div><h1>Title</h1><p>Paragraph</p></div>");
  });

  test("can set properties", () {
    var a = hyper("a", attrs: {'href': "http://google.com"});
    expect(a.toString(), '<a href="http://google.com"></a>');
    var checkbox = hyper("input", attrs: {'name': "yes", 'type': "checkbox"});
    expect(checkbox.toString(), '<input name="yes" type="checkbox" />');
  });

  test("sets styles as text", () {
    var div = hyper("div", attrs: {'style': "color: red;"});
    expect(div.toString(), '<div style="color: red;"></div>');
  });

  test("sets data attributes", () {
    var div = hyper("div", attrs: {"data-value": 5.toString()});
    expect(div.toString(), '<div data-value="5"></div>'); // failing for IE9
  });

  test("can use element exports", () {
    expect(h.div().toString(), "<div></div>");
  });

  test("void elements render without a closing tag", () {
    expect(h.img().toString(), "<img />");
  });

  test("void elements can have attrs", () {
    expect(
        h.img(
          attrs: {'src': 'https://i.imgur.com/bLV8BPS.jpg'},
        ).toString(),
        '<img src="https://i.imgur.com/bLV8BPS.jpg" />');
  });

  test("void elements render without a closing tag when using hyper", () {
    expect(hyper("img").toString(), "<img />");
  });

  test("special characters are correctly escaped in text content", () {
    expect(hyper("h1", children: [t('<hello "world">')]).toString(),
        '<h1>&lt;hello "world"&gt;</h1>');
  });

  test("special characters are correctly escaped in attributes", () {
    var a = h.div(attrs: {'data-title': 'Hello "world"'});
    expect(a.toString(), '<div data-title="Hello &quot;world&quot;"></div>');
  });
}
