/*
s3.next() returns chunks of text of equal size. Create a wrapper around it to return one line (separated with `\n`) per next() call.
*/

const EOF = "<EOF>"

function NextFinder(s3) {
  this.buffer = "";
  this.end = false;
  this.s3 = s3;
  
  this.next = function() {
    if (this.buffer.indexOf("\n") == -1 && this.end == false) {
      this.buffer += this.readMore();
    }

    if (this.buffer != "") {
      return this.firstLine();
    } else {
      if (this.end == false) {
        return "";
      } else {
        return EOF;
      }
    }
  };
  
  this.firstLine = function() {
    const idx = this.buffer.indexOf("\n");
    let ret;
    if (idx != -1) {
      ret = this.buffer.slice(0, idx);
      this.buffer = this.buffer.slice(idx + 1);
    } else {
      ret = this.buffer;
      this.buffer = "";
    }
    return ret;
  };

  // read more from the s3 until the next new line
  // returns string
  this.readMore = function() {
    let content = "";
    let response;

    do {
      response = this.s3.next();
      if (response) { content += response; }
    } while (content.indexOf("\n") == -1 && response);

    if (!response) { this.end = true; }
    
    return content;
  }
}


function S3(set) {
    this.set = set;
    
    this.next = function() {
        return this.set.shift();
    }
}


const s3 = new S3([
    "first line\nsecond ", "very long", " line\nlast line"
]);
const nf = new NextFinder(s3);

console.log("'" + nf.next() + "'", "== 'first line'");
console.log("'" + nf.next() + "'", "== 'second very long line'");
console.log("'" + nf.next() + "'", "== 'last line'");
console.log("'" + nf.next() + "'", "== '<EOF>'");

