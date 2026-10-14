mod application;
mod config;
mod window;

use gettextrs::{LocaleCategory, gettext};
use gtk::{gio, glib};

use self::application::ExampleApplication;
use self::config::{GETTEXT_PACKAGE, LOCALEDIR, RESOURCES_FILE};

fn setup_gettext() {
    // Prepare i18n
    unsafe {
        gettextrs::setlocale(LocaleCategory::LcAll, "");
    }
    gettextrs::bindtextdomain(*GETTEXT_PACKAGE, *LOCALEDIR)
        .expect("Unable to bind the text domain");
    gettextrs::bind_textdomain_codeset(*GETTEXT_PACKAGE, "UTF-8")
        .expect("Unable to bind the text domain codeset to UTF-8");
    gettextrs::textdomain(*GETTEXT_PACKAGE).expect("Unable to switch to the text domain");
}

fn main() -> glib::ExitCode {
    // Initialize logger
    tracing_subscriber::fmt::init();

    setup_gettext();

    glib::set_application_name(&gettext("GTK Rust Template"));

    let res = gio::Resource::load(*RESOURCES_FILE).expect("Could not load gresource file");
    gio::resources_register(&res);

    let app = ExampleApplication::default();
    app.run()
}
#[cfg(test)]
mod tests {
    #[allow(unused)]
    use super::*;

    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }
}
