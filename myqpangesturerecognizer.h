#ifndef MYQPANGESTURERECOGNIZER_H
#define MYQPANGESTURERECOGNIZER_H

#include <QGestureRecognizer>

class MyQPanGestureRecognizer : public QGestureRecognizer
{
public:
    MyQPanGestureRecognizer();

    QGesture *create(QObject *target);
    QGestureRecognizer::Result recognize(QGesture *state, QObject *watched, QEvent *event);
    void reset(QGesture *state);
};

#endif // MYQPANGESTURERECOGNIZER_H
