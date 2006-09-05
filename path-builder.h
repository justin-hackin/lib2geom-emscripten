#ifndef GEOM_PATH_BUILDER_H
#define GEOM_PATH_BUILDER_H

#include "path.h"

namespace Geom {

class PathBuilder {
public:
    PathBuilder() : _current_subpath(NULL) {}

    void start_subpath_rel(Point const &p0) { start_subpath(p0 + _current_point); }
    void start_subpath(Point const &p0) {
        _path._subpaths.push_back(SubPath());
        _current_subpath = &_path._subpaths.back();
        _current_subpath->closed = false;
        _current_subpath->handles.push_back(p0);
        _initial_point = _current_point = p0;
    }

    void push_line_rel(Point const &p0) { push_line(p0 + _current_point); }
    void push_line(Point const &p1) {
        if (!_current_subpath) start_subpath(_current_point);
        _current_subpath->cmd.push_back(lineto);
        _current_subpath->handles.push_back(p1);
        _current_point = p1;
    }

    void push_line_rel(Point const &p0, Point const &p1) { push_line(p0 + _current_point, p1 + _current_point); }
    void push_line(Point const &p0, Point const &p1) {
        if(p0 != _current_point)
            start_subpath(p0);
        push_line(p1);
    }

    void push_horizontal_rel(double x) { push_horizontal(x + _current_point[0]); }
    void push_horizontal(double x) {
        if (!_current_subpath) start_subpath(_current_point);
        Point p;
        p[0] = x;
        p[1] = _current_point[1];
        push_line(p);
    }

    void push_vertical_rel(double y) { push_vertical(y + _current_point[1]); }
    void push_vertical(double y) {
        if (!_current_subpath) start_subpath(_current_point);
        Point p;
        p[0] = _current_point[0];
        p[1] = y;
        push_line(p);
    }

    void push_quad_rel(Point const &p1, Point const &p2) { push_quad(p1 + _current_point, p2 + _current_point); }
    void push_quad(Point const &p1, Point const &p2) {
        if (!_current_subpath) start_subpath(_current_point);
        _current_subpath->cmd.push_back(quadto);
        _current_subpath->handles.push_back(p1);
        _current_subpath->handles.push_back(p2);
        _current_point = p2;
    }

    void push_quad_rel(Point const &p0, Point const &p1, Point const &p2) {
        push_quad(p0 + _current_point, p1 + _current_point, p2 + _current_point);
    }
    void push_quad(Point const &p0, Point const &p1, Point const &p2) {
        if(p0 != _current_point)
            start_subpath(p0);
        push_quad(p1, p2);
    }

    void push_cubic_rel(Point const &p1, Point const &p2, Point const &p3) {
        push_cubic(p1 + _current_point, p2 + _current_point, p3 + _current_point);
    }
    void push_cubic(Point const &p1, Point const &p2, Point const &p3) {
        if (!_current_subpath) start_subpath(_current_point);
        _current_subpath->cmd.push_back(cubicto);
        _current_subpath->handles.push_back(p1);
        _current_subpath->handles.push_back(p2);
        _current_subpath->handles.push_back(p3);
        _current_point = p3;
    }

    void push_cubic_rel(Point const &p0, Point const &p1, Point const &p2, Point const &p3) {
        push_cubic(p1 + _current_point, p1 + _current_point, p2 + _current_point, p3 + _current_point);
    }
    void push_cubic(Point const &p0, Point const &p1, Point const &p2, Point const &p3) {
        if(p0 != _current_point)
            start_subpath(p0);
        push_cubic(p1, p2, p3);
    }

    void push_ellipse(Point const &p1, Point const &p2, Point const &p3, Point const &p4) {
        if (!_current_subpath) start_subpath(_current_point);
        _current_subpath->cmd.push_back(cubicto);
        _current_subpath->handles.push_back(p1);
        _current_subpath->handles.push_back(p2);
        _current_subpath->handles.push_back(p3);
        _current_subpath->handles.push_back(p4);
    }

    void push_ellipse(Point const &radii, double rotation, bool large, bool sweep, Point const &end) {
        //TODO
    }

    void close_subpath() {
        if (_current_subpath) {
            push_line(_initial_point);
            _current_subpath->closed = true;
            _current_subpath = NULL;
        }
    }

    Path const &peek() const { return _path; }

private:
    Path _path;
    SubPath *_current_subpath;
    Point _current_point;
    Point _initial_point;
};

}

#endif 

/*
  Local Variables:
  mode:c++
  c-file-style:"stroustrup"
  c-file-offsets:((innamespace . 0)(substatement-open . 0))
  indent-tabs-mode:nil
  c-brace-offset:0
  fill-column:99
  End:
  vim: filetype=cpp:expandtab:shiftwidth=4:tabstop=8:softtabstop=4 :
*/
