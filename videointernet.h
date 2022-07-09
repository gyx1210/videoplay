#ifndef VIDEOINTERNET_H
#define VIDEOINTERNET_H

#include <QObject>

class VideoInternet :public QObject
{
    Q_OBJECT
public:
    VideoInternet();
    Q_INVOKABLE QString urllink();//获取网络视频链接
private:
    QString link;
};

#endif // VIDEOINTERNET_H
