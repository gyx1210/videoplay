#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include"videointernet.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    qmlRegisterType<VideoInternet, 1>("VideoInternet", 1, 0, "VInternet");
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
