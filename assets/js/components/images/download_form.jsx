import React from 'react'
import PropTypes from 'prop-types'

class DownloadForm extends React.Component {
  static propTypes = {
    images: PropTypes.array
  }

  render () {
    const inputs = this.props.images.map((image) => {
      return <input type='hidden' name='urls[]' value={image.url} />
    })

    return (
      <form method='post' action='https://boxer.mskog.com'>
        {inputs}
        <button className='button is-info'>Download all images</button>
      </form>
    )
  }
}

export default DownloadForm
