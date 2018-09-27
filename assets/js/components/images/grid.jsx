import React from 'react'
import PropTypes from 'prop-types'
import Image from './image'

class Grid extends React.Component {
  static propTypes = {
    images: PropTypes.array
  }

  render () {
    const images = this.props.images.map((image) => {
      return <Image {...image} key={image.url} />
    })

    return (
      <div id='masonry'>
        {images}
      </div>
    )
  }
}

export default Grid
