#include <QDebug>
#include <QEvent>
#include <QGesture>
#include "mygesture.h"

MyQSwipeGesture::MyQSwipeGesture(QObject *parent)
    : QGesture(parent)
{
//    d_func()->gestureType = Qt::SwipeGesture;
}

MyQSwipeGesture::MySwipeDirection MyQSwipeGesture::horizontalDirection() const
{
    //Q_D(const MyQSwipeGesture);
    if (m_swipeAngle < 0 || m_swipeAngle == 90 || m_swipeAngle == 270)
        return MyQSwipeGesture::NoDirection;
    else if (m_swipeAngle < 90 || m_swipeAngle > 270)
        return MyQSwipeGesture::Right;
    else
        return MyQSwipeGesture::Left;
}

MyQSwipeGesture::MySwipeDirection MyQSwipeGesture::verticalDirection() const
{
    //Q_D(const MyQSwipeGesture);
    if (m_swipeAngle <= 0 || m_swipeAngle == 180)
        return MyQSwipeGesture::NoDirection;
    else if (m_swipeAngle < 180)
        return MyQSwipeGesture::Up;
    else
        return MyQSwipeGesture::Down;
}

qreal MyQSwipeGesture::swipeAngle() const
{
    return m_swipeAngle;
}

void MyQSwipeGesture::setSwipeAngle(qreal value)
{
    m_swipeAngle = value;
}

