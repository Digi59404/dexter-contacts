# project name and programming language
project('org.pantheon.dexter-contacts', 'vala', 'c', version: '0.1.0')


add_project_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language: 'c')
add_project_arguments('--vapidir', join_paths(meson.current_source_dir(), 'vapi'), language: 'vala')

i18n = import('i18n')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

dependencies = [
    dependency('gio-unix-2.0', version: '>=2.20'),
    dependency('granite'),
    dependency('gobject-2.0'),
    dependency('glib-2.0'),
    dependency('gio-2.0'),
    dependency('gee-0.8'),
    dependency('gtk+-3.0', version: '>=3.11.6'),
    dependency('granite'),
    dependency('folks'),
    dependency('champlain-gtk-0.12'),
    dependency('champlain-0.12'),
    dependency('clutter-1.0'),
]

icon_sizes = ['128', '256']

foreach i : icon_sizes
    install_data(
        join_paths('data/icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('data/icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

config_data = configuration_data()
config_data.set('EXEC_NAME', meson.project_name())


conf_data = configuration_data()
conf_data.set_quoted('PROJECT_NAME', meson.project_name())
conf_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf_data.set_quoted('VERSION', meson.project_version())
conf_data.set_quoted('PREFIX', get_option('prefix'))

desktop_in_file = configure_file(
    input: join_paths('data', meson.project_name() + '.desktop.in.in'),
    output: '@BASENAME@',
    configuration: config_data
)

#desktop_file = i18n.merge_file(
#    input: desktop_in_file,
#    output: meson.project_name() + '.desktop',
#    po_dir: join_paths(meson.source_root(), 'po'),
#    type: 'desktop',
#    install: true,
#    install_dir: join_paths(get_option('datadir'), 'applications')
#)

#appstream_file = i18n.merge_file(
#    input: join_paths (meson.source_root(), 'data', meson.project_name() + '.appdata.xml.in'),
#    output: '@BASENAME@',
#    po_dir: join_paths(meson.source_root(), 'po'),
#    install: true,
#    install_dir: join_paths(get_option('datadir'), 'metainfo')
#)


code_files = files(
    'src/Application.vala',
    'src/Window.vala',
    'src/ContactsList.vala',
    'src/ContactsManager.vala',
    'src/ContactView.vala',
    'src/Dialogs/ContactDialog.vala',
    'src/Dialogs/InfoPanel.vala',
    'src/Widgets/ContactAddressEntry.vala',
    'src/Widgets/ContactBody.vala',
    'src/Widgets/ContactImage.vala',
    'src/Widgets/ContactItem.vala',
    'src/Widgets/EntryGrid.vala',
    'src/Widgets/HeaderItem.vala',
    'src/Widgets/MapView.vala'
)

executable(
    meson.project_name(),
    code_files,
    dependencies: dependencies,
    install: true
)

#subdir('po')

extra_args = ['--disable-more-warnings']