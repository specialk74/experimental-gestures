#include <QDebug>
#include <QGesture>
#include <QGraphicsSceneMouseEvent>
#include <QLineF>
#include <QMouseEvent>
#include <QVariant>

#include "mygesturerecognizer.h"

MyQSwipeGestureRecognizer::MyQSwipeGestureRecognizer()
{
}

QGesture *MyQSwipeGestureRecognizer::create(QObject *target)
{
    Q_UNUSED(target)
    return new QSwipeGesture;
}

QGestureRecognizer::Result MyQSwipeGestureRecognizer::recognize(QGesture *state,
                                                                QObject *,
                                                                QEvent *event)
{
    QSwipeGesture *g = static_cast<QSwipeGesture *>(state);

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
#if 0
    if (event->type() == QEvent::MouseButtonPress || event->type() == QEvent::MouseButtonDblClick
            || event->type() == QEvent::GraphicsSceneMousePress || event->type() == QEvent::GraphicsSceneMouseDoubleClick) {
        g->setHotSpot(globalPos);
        g->setProperty("startPos", globalPos);
        g->setProperty("pressed", QVariant::fromValue<bool>(true));
        qDebug() << __FILE__ << __LINE__ << __func__;
        return QGestureRecognizer::TriggerGesture | QGestureRecognizer::ConsumeEventHint;
    } else if (event->type() == QEvent::MouseMove || event->type() == QEvent::GraphicsSceneMouseMove) {
        if (g->property("pressed").toBool()) {
            g->setSwipeAngle(10.0);
            //QPoint offset = globalPos - g->property("startPos").toPoint();
            //g->setLastOffset(g->offset());
            //g->setOffset(QPointF(offset.x(), offset.y()));
            qDebug() << __FILE__ << __LINE__ << __func__;
            return QGestureRecognizer::TriggerGesture | QGestureRecognizer::ConsumeEventHint;
        }
        return QGestureRecognizer::CancelGesture;
    } else if (event->type() == QEvent::MouseButtonRelease || event->type() == QEvent::GraphicsSceneMouseRelease) {
        return QGestureRecognizer::FinishGesture | QGestureRecognizer::ConsumeEventHint;
    }
#else
    if (event->type() == QEvent::MouseButtonPress || event->type() == QEvent::MouseButtonDblClick
            || event->type() == QEvent::GraphicsSceneMousePress || event->type() == QEvent::GraphicsSceneMouseDoubleClick) {
        //qDebug() << "QEvent::MouseButtonPress";
        g->setHotSpot(globalPos);
        g->setProperty("startPos", globalPos);
        g->setProperty("pressed", QVariant::fromValue<bool>(true));
        //return QGestureRecognizer::TriggerGesture | QGestureRecognizer::ConsumeEventHint;
        return QGestureRecognizer::MayBeGesture | QGestureRecognizer::ConsumeEventHint;
    }
    else if (event->type() == QEvent::MouseMove || event->type() == QEvent::GraphicsSceneMouseMove)
    {
        //qDebug() << "QEvent::MouseMove" << g->property("pressed").toBool();
        if (g->property("pressed").toBool()) {
            g->setSwipeAngle(QLineF(g->property("startPos").toPoint(), globalPos).angle());
            //return QGestureRecognizer::TriggerGesture | QGestureRecognizer::ConsumeEventHint;
            return QGestureRecognizer::MayBeGesture | QGestureRecognizer::ConsumeEventHint;
        }
        return QGestureRecognizer::CancelGesture;
    }
    else if (event->type() == QEvent::MouseButtonRelease || event->type() == QEvent::GraphicsSceneMouseRelease)
    {
        const qreal threshold = 50.0;
        QLineF lineF (g->property("startPos").toPoint(), globalPos);

        g->setProperty("pressed", QVariant::fromValue<bool>(false));
        g->setProperty("startPos", QVariant());

        if ((qAbs(lineF.dx()) > threshold) || (qAbs(lineF.dy()) > threshold))
        {
            //qDebug() << "QEvent::MouseButtonRelease" << g->property("pressed").toBool();
            return QGestureRecognizer::FinishGesture | QGestureRecognizer::ConsumeEventHint;
        }
    }
#endif

    return QGestureRecognizer::Ignore;
}

void MyQSwipeGestureRecognizer::reset(QGesture *state)
{
    QSwipeGesture *g = static_cast<QSwipeGesture *>(state);
    g->setSwipeAngle(0.0);
    g->setProperty("startPos", QVariant());
    g->setProperty("pressed", QVariant::fromValue<bool>(false));
    QGestureRecognizer::reset(state);
}
