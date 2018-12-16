// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2014 Dexter Contacts Developers (https://launchpad.net/dexter-contacts)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: Corentin Noël <corentin@elementaryos.org>
 */
namespace Dexter {
    public class Window : Gtk.Window {
        private Gtk.Popover addressbook_popover;
        private Gtk.ToggleButton address_books_button;
        private Granite.Widgets.Welcome welcome_view;
        private Gtk.Stack contact_stack;
        public Window () {
            var headerbar = new Gtk.HeaderBar ();
            headerbar.show_close_button = true;
            set_titlebar (headerbar);
            title = "Contacts";
            window_position = Gtk.WindowPosition.CENTER;
            set_default_size (850, 550);

            address_books_button = new Gtk.ToggleButton ();
            address_books_button.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            address_books_button.toggled.connect (() => {toggle_address_books_popover (address_books_button.active);});

            var add_contact_button = new Gtk.Button.from_icon_name ("contact-new", Gtk.IconSize.LARGE_TOOLBAR);
            add_contact_button.clicked.connect (() => {show_creation_dialog ();});

            var search_entry = new Gtk.SearchEntry ();
            search_entry.placeholder_text = "Search Contacts";

            headerbar.pack_start (add_contact_button);
            headerbar.pack_end (address_books_button);
            headerbar.pack_end (search_entry);

            destroy.connect (() => {
                Gtk.main_quit ();
            });


            var main_stack = new Gtk.Stack ();

            this.setup_welcome_pane(main_stack);
            this.setup_contacts_pane(main_stack);

            main_stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
            main_stack.set_visible_child_name ("welcome_view");

            var contact_manager = ContactsManager.get_default ();
            contact_manager.individual_added.connect (() => {
                main_stack.set_visible_child_name ("main_view");
            });

            add (main_stack);
            show_all ();
        }

        private void setup_contacts_pane(Gtk.Stack main_stack){
            var contacts_list = new ContactsList ();
            var current_view = new ContactView ();
            contacts_list.contact_selected.connect (current_view.set_contact);
            contact_stack = new Gtk.Stack ();
            contact_stack.add (current_view);

            var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
            paned.set_position (150);
            paned.pack1 (contacts_list, false, false);
            paned.pack2 (contact_stack, true, false);

            main_stack.add_named (paned, "main_view");
        }

        private void setup_welcome_pane(Gtk.Stack main_stack){
            welcome_view = new Granite.Widgets.Welcome ("No Contacts Found", _("Try to add some"));
            welcome_view.append ("contact-new", _("Create"), _("Create a new contact"));
            welcome_view.append ("document-import", _("Import"), _("Add a vCard"));
            welcome_view.append ("document-import", _("Exit Contacts"), _("Close Contacts For Now!"));
            welcome_view.show_all ();


            welcome_view.activated.connect ((index) => {
                switch (index) {
                    case 0:
                        try {
                            this.show_creation_dialog ();
                        } catch (Error e) {
                            warning (e.message);
                        }
                        break;
                    case 1:
                        try {
                            //this.app.openProjectFolder();
                        } catch (Error e) {
                            warning (e.message);
                        }
                        break;
                    case 2:
                        try {
                            this.exit_application();
                        } catch (Error e) {
                            warning (e.message);
                        }
                        break;
                    }
                });
            main_stack.add_named (welcome_view, "welcome_view");
        }

        private void show_creation_dialog () {
            var contact_dialog = new ContactDialog ();
            contact_dialog.transient_for = this;
            contact_dialog.show_all ();
        }

        private void toggle_address_books_popover (bool active) {
            if (active == false) {
                if (addressbook_popover == null)
                    return;
                addressbook_popover.hide ();
                addressbook_popover.destroy ();
            } else {
                addressbook_popover = new Gtk.Popover (address_books_button);
                addressbook_popover.add (new Gtk.Label ("Address books HERE"));
                addressbook_popover.hide.connect (() => {address_books_button.active = false;});
                addressbook_popover.show.connect (() => {address_books_button.active = true;});
                addressbook_popover.show_all ();
            }
        }

        private void exit_application(){
            Gtk.main_quit();
        }
    }
}
