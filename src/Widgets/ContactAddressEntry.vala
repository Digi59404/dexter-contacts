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
    public class ContactAddressEntry : Gtk.ListBoxRow {
        private Widgets.MapView map_view;

        public ContactAddressEntry (string kind, Folks.PostalAddress address) {
            var container = new Gtk.Grid ();
            container.expand = true;
            container.row_spacing = 12;
            container.column_spacing = 6;
            container.row_homogeneous = true;

            var kind_label = new Gtk.Label ("<b>%s</b>".printf (kind));
            kind_label.use_markup = true;
            ((Gtk.Misc) kind_label).xalign = 1;

            var locality_label = new Gtk.Label (address.locality);
            ((Gtk.Misc) locality_label).xalign = 0;
            locality_label.hexpand = true;

            map_view = new Widgets.MapView ();

            int current_line = 0;

            if (address.street != null && address.street != "") {
                var street_label = new Gtk.Label (address.street);
                container.attach (street_label, 3, current_line++, 4, 1);
            }

            if (address.region != null && address.region != "") {
                var region_label = new Gtk.Label (address.region);
                container.attach (region_label, 3, current_line++, 4, 1);
            }

            container.attach (map_view, 0, current_line, 7, 6);
            add (container);

            compute_location.begin (address.to_string ());
        }

        private async void compute_location (string loc) {
            /*var forward = new Geocode.Forward.for_string (loc);
            try {
                forward.set_answer_count (1);
                var places = forward.search ();
                foreach (var place in places) {
                    Idle.add (() => {
                        map_view.set_point (place.location.latitude, place.location.longitude);
                        return false;
                    });
                }
            } catch (Error error) {
                debug (error.message);
            } */
        }
    }
}
