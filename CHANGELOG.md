## 0.3.0

- `Day`, `Week`, `Month` and `Year` are final classes read through their
  fields instead of `getYear()`-style methods.
- `fullWeeksOfMonth` counts the weeks of a month by date: a month that starts
  on a Monday keeps its first week, and one that ends on a Sunday its last.
- Moved into the application workspace.
