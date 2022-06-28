cmake_minimum_required(VERSION 3.23)

project(videoplay VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

qt_add_resources(qrc_FILES img.qrc)


qt_add_executable(appvideoplay
    main.cpp  ${qrc_FILES}
)
qt_add_qml_module(appvideoplay
    URI videoplay
    VERSION 1.0
    QML_FILES main.qml
    Actions.qml
    Content.qml
    Open.qml
    PlaySlider.qml
    Playerv.qml
    SoundSlider.qml
)

set_target_properties(appvideoplay PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appvideoplay
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appvideoplay
    PRIVATE Qt6::Quick)
target_link_libraries(appvideoplay PRIVATE Qt6::Multimedia)
