#ifndef MYGESTURERECOGNIZER_H
#define MYGESTURERECOGNIZER_H

#include <QGestureRecognizer>

class MyQSwipeGestureRecognizer : public QGestureRecognizer
{
public:
    MyQSwipeGestureRecognizer();

    QGesture *create(QObject *target);
    QGestureRecognizer::Result recognize(QGesture *state, QObject *watched, QEvent *event);
    void reset(QGesture *state);
};

#endif // MYGESTURERECOGNIZER_H
