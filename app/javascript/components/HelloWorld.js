import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class HelloWorld extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div>
          Name: {this.props.name}
        </div>
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  name: PropTypes.string
};
export default HelloWorld
