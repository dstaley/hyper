import './dom_elements.dart';

const _reservedAttrs = ['textContent'];

/// The return type of a hyper function representing an HTML element including
/// it's attributes and children.
class Element {
  /// Creates a new Hyper Element.
  Element(this._tag, {Map<String, Object> attrs, List<Element> children}) {
    _attrs = attrs == null ? {} : attrs;
    _children = children == null ? [] : children;
  }

  String _tag;
  Map<String, Object> _attrs;
  List<Element> _children;

  bool _hasAttrs() => _attrs.isNotEmpty;

  String _printAttrs() => _attrs.keys
      .where((String k) => !_reservedAttrs.contains(k))
      .map((k) => '$k="${_attrs[k]}"')
      .join(' ');

  String _childrenToString() => _children.map((c) => c.toString()).join('');

  /// Returns the element tree as an HTML string.
  String toString() {
    if (_tag == '_') {
      return _attrs['textContent'];
    }

    if (voidElements.contains(_tag)) {
      return "<$_tag${_hasAttrs() ? ' ${_printAttrs()}' : ''} />";
    }

    return "<$_tag${_hasAttrs() ? ' ${_printAttrs()}' : ''}>${_childrenToString()}</$_tag>";
  }
}

/// A convience function that creates an instance of [Element]. Primarily used
/// when you want to create a non-standard element such as `<custom-element>`.
Element hyper(
  String tag, {
  Map<String, Object> attrs,
  List<Element> children,
}) =>
    Element(tag, attrs: attrs, children: children);

/// Function that creates a text node.
Element t(String text) => Element('_', attrs: {'textContent': text});
