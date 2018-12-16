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
    public class ContactItem : Gtk.ListBoxRow {
        public Folks.Individual individual;
        private Gtk.Label name_label;
        public ContactItem (Folks.Individual individual) {
            this.individual = individual;

            string name = null;
            var structured_name = individual.structured_name;
            if (structured_name != null) {
                if (structured_name.family_name == null || structured_name.family_name == "") {
                    name = structured_name.given_name;
                } else {
                    name = "%s <b>%s</b>".printf (structured_name.given_name, structured_name.family_name);
                }
            } else {
                if (individual.full_name != null) {
                    name = individual.full_name;
                } else {
                    name = individual.nickname;
                }
            }

            name_label = new Gtk.Label (name);
            ((Gtk.Misc) name_label).xalign = 0;
            name_label.use_markup = true;
            name_label.ellipsize = Pango.EllipsizeMode.END;
            name_label.margin = 6;
            name_label.margin_start = 12;
            add (name_label);
        }
        
        public string get_sort_name () {
            return name_label.label;
        }
    }
}
