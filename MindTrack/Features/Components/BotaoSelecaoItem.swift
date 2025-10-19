import SwiftUI

struct BotaoSelecaoItem: View {
    
    var tituloItem: String
    var estaSelecionado: Bool
    var acaoBotao: () -> Void
    
    var body: some View {
        Button(action: acaoBotao) {
            HStack {
                Text(tituloItem)
                    .font(.body)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: estaSelecionado ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(estaSelecionado ? .purple : .gray)
                    .symbolEffect(estaSelecionado ? .bounce : .none)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}
