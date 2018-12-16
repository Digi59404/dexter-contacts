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
     public class App : Granite.Application {

        construct {
            // This allows opening files. See the open() method below.
            flags |= ApplicationFlags.HANDLES_OPEN;

            // App info
            build_version = "0.2.0";

            program_name = "Contacts";
            exec_name = "dexter-contacts";

            application_id = "org.pantheon.dexter-contacts";
            app_launcher = exec_name+".desktop";
        }

        public Window window;
        
        public App () {
            Object(
                application_id: "org.pantheon.dexter-contacts", 
                flags: ApplicationFlags.FLAGS_NONE
            );
        }
            
        protected override void activate () {
            if (get_windows () != null) {
                get_windows ().data.present (); // present window if app is already running
                return;
            }

            window = new Window ();
            window.show_all ();

            Gtk.main ();
        }

        public static int main (string[] args) {
            //Gtk.init (ref args);
            Clutter.init (ref args);
            var app = new App ();
            return app.run (args);
        }
    }
}
