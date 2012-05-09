package jousse
package blog

import java.util.Date

case class Post(title: String, content: String, createdAt: Date) extends Ordered[Date] {

  def compare(that: Date): Int = {
    createdAt.compare(that)
  }

}