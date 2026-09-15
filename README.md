# Library Mobile App: Known Limitations

## Missing functionality

- Password changing is not available because the backend does not provide a password-change endpoint.
- Members cannot register themselves. An administrator must create each member and their login account.
- Creating a member and creating their login account are two separate backend requests. If the second request fails, the member may exist without a login account.

## UI scope

UI design was not the main focus of the `main` branch. It contains the manually implemented, working components with a simple interface and without extensive visual polish.

The `ui-design` branch is used separately for experimenting with and expanding the visual design.
