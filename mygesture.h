#ifndef MYGESTURE_H
#define MYGESTURE_H

#include <QGesture>
#include <QGestureRecognizer>

class Q_GUI_EXPORT MyQSwipeGesture : public QGesture
{
    Q_OBJECT
//    Q_DECLARE_PRIVATE(MyQSwipeGesture)
    Q_ENUMS(MySwipeDirection)

    Q_PROPERTY(MySwipeDirection horizontalDirection READ horizontalDirection STORED false)
    Q_PROPERTY(MySwipeDirection verticalDirection READ verticalDirection STORED false)
    Q_PROPERTY(qreal swipeAngle READ swipeAngle WRITE setSwipeAngle)
//    Q_PRIVATE_PROPERTY(MyQSwipeGesture::d_func(), qreal velocity READ velocity WRITE setVelocity)

public:
    enum MySwipeDirection { NoDirection, Left, Right, Up, Down };
    MyQSwipeGesture(QObject *parent = 0);

    MySwipeDirection horizontalDirection() const;
    MySwipeDirection verticalDirection() const;

    qreal swipeAngle() const;
    void setSwipeAngle(qreal value);

    friend class MyQSwipeGestureRecognizer;

private:
    qreal m_swipeAngle;
};

#endif // MYGESTURE_H
