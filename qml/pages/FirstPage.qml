import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.animatorPush(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("QMLDateFrom")
            }
            TextField {
                id: nome
                x: Theme.horizontalPageMargin
                label: qsTr("Insert the name")
                text: qsTr("numerone")
            }
            TextField {
                id: data
                x: nome.bottom
                label: qsTr("Insert the date")
                text: qsTr("2022-10-07")
            }
            Button {
                id: button
                text: qsTr("Choose a date")
                onClicked: {
                    var dialog = pageStack.push(pickerComponent, {
                    date: new Date('2022/10/')
                })
                dialog.accepted.connect(function() {
                    data.text = dialog.date.year+'-'+dialog.date.month+'-'+dialog.date.date
                })
           }
           Component {
                id: pickerComponent
                DatePickerDialog {}
          }
          Button {
                id: calculate
                x: data.bottom
                text: qsTr("Calculate")
                onClicked: {
                    var now=new Date()
                    var before=new Date(data.text)
                    var offset=now.getTime()-before.getTime()
                    offset=Math.floor(offset / (1000 * 3600 * 24))
                    if (before.getDate()===now.getDate())
                        if (before.getMonth()===now.getMonth())
                            anniversary.text=qsTr("Is your anniversary");
                        else
                            anniversary.text=qsTr("Is your mesiversary");
                    result.text=qsTr("You met ")+nome.text+qsTr(" about ")+offset+qsTr(" days ago.")
                }

            }
            Label {
                x: calculate.bottom
                id: result
                text: qsTr("")
            }
            Label {
                x: result.bottom
                id: anniversary
                text: qsTr("")
            }
        }
    }
}
