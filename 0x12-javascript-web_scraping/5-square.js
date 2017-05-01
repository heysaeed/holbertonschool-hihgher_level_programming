#!/usr/bin/node

const Rectangle = require('./4-rectangle.js').Rectangle;

exports.Square = function (size) {
  Rectangle.call(this, size, size);
  this.size = size;
  return this;
};
