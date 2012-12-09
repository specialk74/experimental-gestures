#include <QDebug>
#include <QGesture>
#include <QGraphicsSceneMouseEvent>
#include <QLineF>
#include <QMouseEvent>
#include <QVariant>

#include "myqpangesturerecognizer.h"

MyQPanGestureRecognizer::MyQPanGestureRecognizer()
{
}

QGesture *MyQPanGestureRecognizer::create(QObject *target)
{
    Q_UNUSED(target)
    return new QPanGesture;
}

QGestureRecognizer::Result MyQPanGestureRecognizer::recognize(QGesture *state,
                                                                QObject *,
                                                                QEvent *event)
{
    QPanGesture *g = static_cast<QPanGesture *>(state);

    QPoint globalPos;
    switch (event->type()) {
    case QEvent::GraphicsSceneMousePress:
    case QEvent::GraphicsSceneMouseDoubleClick:
    case QEvent::GraphicsSceneMouseMove:
    case QEvent::GraphicsSceneMouseRelease:
        globalPos = static_cast<QGraphicsSceneMouseEvent *>(event)->screenPos();
        break;
    case QEvent::MouseButtonPress:
    case QEvent::MouseMove:
    case QEvent::MouseButtonRelease:
        globalPos = static_cast<QMouseEvent *>(event)->globalPos();
        break;
    default:
        break;
    }

    if (event->type() == QEvent::MouseButtonPress || event->type() == QEvent::MouseButtonDblClick
            || event->type() == QEvent::GraphicsSceneMousePress || event->type() == QEvent::GraphicsSceneMouseDoubleClick) {
        g->setHotSpot(globalPos);
        g->setProperty("startPos", globalPos);
        g->setProperty("pressed", QVariant::fromValue<bool>(true));

        g->setOffset(QPointF());
        g->setLastOffset(g->offset());
        return QGestureRecognizer::MayBeGesture;
    }
    else if (event->type() == QEvent::MouseMove || event->type() == QEvent::GraphicsSceneMouseMove)
    {
        if (g->property("pressed").toBool())
        {
            const qreal thresholdUp = 10.0;
            const qreal thresholdDown = -10.0;
            g->setLastOffset(g->offset());


            g->setOffset(QPointF(g->property("startPos").toPoint() - globalPos) / 2);
            if (g->offset().x() > thresholdUp  || g->offset().y() > thresholdUp ||
                    g->offset().x() < thresholdDown || g->offset().y() < thresholdDown) {
                return QGestureRecognizer::TriggerGesture;
            } else {
                return QGestureRecognizer::MayBeGesture;
            }
        }
        return QGestureRecognizer::CancelGesture;
    }
    else if (event->type() == QEvent::MouseButtonRelease || event->type() == QEvent::GraphicsSceneMouseRelease)
    {
        g->setProperty("pressed", QVariant::fromValue<bool>(false));

        if (g->state() != Qt::NoGesture)
        {
            g->setLastOffset(g->offset());
            g->setOffset(QPointF(g->property("startPos").toPoint() - globalPos) / 2);
            return QGestureRecognizer::FinishGesture;
        } else {
            return QGestureRecognizer::CancelGesture;
        }
    }

    return QGestureRecognizer::Ignore;
}

void MyQPanGestureRecognizer::reset(QGesture *state)
{
    QPanGesture *g = static_cast<QPanGesture *>(state);
    g->setProperty("startPos", QVariant());
    g->setProperty("pressed", QVariant::fromValue<bool>(false));
    QGestureRecognizer::reset(state);
}
