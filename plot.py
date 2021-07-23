import matplotlib.pyplot as plt

nodes = [1, 2, 4, 8, 16, 32, 64, 96, 128, 150]
x = [1, 2, 4, 8, 16, 32, 64]

fig, axs = plt.subplots(nrows = 2, ncols = 1)
for i in range(7):
    y1 = []
    for j in nodes:
        with open('randrw/bws/bw'+str(j)) as file:
            tmp = file.readlines()
            y1.append(float(tmp[i]))
    axs[0].plot(nodes, y1, 'o--', label = "jobs="+str(2**i))

    y2 = []
    for k in nodes:
        with open("randrw/"+str(k)+"-node/iops"+str(2**i)) as file:
            tmp = file.readlines()[-1]
            y2.append(float(tmp))
    print(y2)
    axs[1].plot(nodes, y2, 'o--', label = "jobs="+str(2**i))

axs[0].set_xticks(nodes)
axs[0].legend()
axs[0].set_xlabel('Nodes')
axs[0].set_ylabel('MB/s')
axs[0].set_title('Bandwidth / n nodes')

axs[1].set_xticks(nodes)
axs[1].legend()
axs[1].set_xlabel('Nodes')
axs[1].set_ylabel('IOPS')
axs[1].set_title('IOPS / n nodes')

plt.show()
