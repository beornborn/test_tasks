//@flow
import styled from 'styled-components'
import { palette } from 'Theme'

const getColor = (color: string) => {
  switch (color) {
    case 'green': return '#9bff9a'
    case 'red': return '#ffd2d2'
  }
}

export const Container = styled.div`
  display: flex;
  flex-direction: column;
  margin: 20px 0;
  box-shadow: rgba(0, 0, 0, 0.12) 0px 1px 6px, rgba(0, 0, 0, 0.12) 0px 1px 4px;
  border-radius: 2px;
  background-color: ${p => getColor(p.color)}
`
export const Header = styled.div`
  display: flex;
  flex-directin: row;
  flex-grow: 1;
  padding: 20px;
  font-size: 17px;
  border-bottom: 1px solid ${palette.silverChalice};
`
export const Name = styled.div`
  display: flex;
  flex-grow: 1;
`
export const Content = styled.div`
  display: flex;
  flex-direction: column;
  padding: 20px;
`
export const Row = styled.div`
  display: flex;
  flex-direction: row;
`
export const Label = styled.div`
  display: flex;
  font-weight: bold;
  padding-right: 20px;
`
