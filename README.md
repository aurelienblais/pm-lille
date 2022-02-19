<div id="top"></div>

<br />
<div align="center">
  <a href="https://github.com/aurelienblais/pm-lille">
    <img src="app/assets/images/logo.jpg" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">PM-Lille</h3>

  <p align="center">
    A small planning manager
  </p>
</div>

## About The Project

A small application used by the Lille's local police (but it could be used by anybody with a bit of rewording)

### Features

* Team & ranks management
* Login-less access for agents (using a private magic-link)
* Logged access for managers
* Recurring absences
* Chat & room system (with e-mail notifications and broadcast tools)
* Global dashboard (latest messages, most occuring absences)

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [AdminLTE](https://adminlte.io/themes/v3/)
* [Chart.js](https://chartjs.org/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

Ruby, node and yarn should be installed.

This project was built using [ASDF](https://asdf-vm.com/).

If you're also using ASDF, make sure all the required plugins are also installed and run `asdf install`
You might also check `.tool-versions` if you're using another version manager.

### Installation

1. Clone the repository
2. Create and fill `.env` with
```
DATABASE_USERNAME=
DATABASE_PASSWORD=
DATABASE_HOST=
DEFAULT_ROOM_ID=1
```
3. Run `bin/rails setup` and `yarn install`
4. Run `bin/rails db:seed`
5. You should be able to run the app using Foreman `foreman start -f Procfile.dev`
6. a. The first user must be manually created through `bin/rails console` using 
```ruby
User.create!(
  email: "fillme@example.com",
  password: "my_secret_password",
  password_confirmation: "my_secret_password",
  rank: :superadmin
)
```
6. b. Users can also be registered using the signup form, but the account must then be manually activated through the interface by an admin or superadmin.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>

## Credits

* The template used for this README was created by [@othneildrew](https://github.com/othneildrew/Best-README-Template)